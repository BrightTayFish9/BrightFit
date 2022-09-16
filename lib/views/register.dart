import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/human_readable_categories.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:bright_fit/views/root.dart';
import 'package:bright_fit/widgets/small_weighter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

///Creates a new user
class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> _key = new GlobalKey();
  String name, password, email;

  bool _autoValidate = false;

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REGISTER',
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline2.fontSize),
        ),
      ),
      body: Builder(
        builder: (context) => ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Form(
              key: _key,
              autovalidateMode: AutovalidateMode.disabled,
              child: formUI(),
            )
          ],
        ),
      ),
    );
  }

  Widget formUI() {
    double errorSize = 25.0;
    return Column(
      children: <Widget>[
        TextFormField(
          enabled: !isLoading,
          decoration: InputDecoration(
              hintText: 'USERNAME', errorStyle: TextStyle(fontSize: errorSize)),
          maxLength: 60,
          validator: validateName,
          onSaved: (val) {
            name = val;
          },
        ),
        TextFormField(
          enabled: !isLoading,
          decoration: InputDecoration(
              hintText: 'PASSWORD', errorStyle: TextStyle(fontSize: errorSize)),
          maxLength: 24,
          validator: validatePassword,
          onSaved: (val) {
            password = val;
          },
        ),
        TextFormField(
          enabled: !isLoading,
          decoration: InputDecoration(
              hintText: 'EMAIL', errorStyle: TextStyle(fontSize: errorSize)),
          keyboardType: TextInputType.emailAddress,
          maxLength: 32,
          validator: validateEmail,
          onSaved: (val) {
            email = val;
          },
        ),
        ElevatedButton(
          child: Text(
            'LET\'S GO!',
            style: TextStyle(fontSize: 50),
          ),
          onPressed: !isLoading ? () => submit() : null,
        ),
        Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: SmallWeighter(),
        )
      ],
    );
  }

  String validateName(String value) {
    if (value.length == 0) {
      return 'USERNAME IS REQUIRED!';
    }
    if (value.length < 3) {
      return 'USERNAME MUST BE AT LEAST 3 CHARACTERS';
    }
    String pattern = '^[a-zA-Z0-9_]*\$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'ONLY USE NUMBERS, LETTERS, OR UNDERSCORES "_"';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return 'PASSWORD IS REQUIRED!';
    }
    if (value.length < 6) {
      return 'PASSWORD MUST BE AT LEAST 6 CHARACTERS';
    }
    return null;
  }

  String validateEmail(String value) {
    if (value.length == 0) {
      return 'EMAIL IS REQUIRED!';
    }
    if (!EmailValidator.validate(value)) {
      return 'PLEASE ENTER A VALID EMAIL';
    }
    return null;
  }

  submit() async {
    if (!_key.currentState.validate()) {
      setState(() {
        _autoValidate = true;
      });
    } else {
      _key.currentState.save();
      WordPress wordPress = WordPress(
        baseUrl: 'https://brightontaylorfitness.com/',
        authenticator: WordPressAuthenticator.JWT,
      );

      setState(() {
        isLoading = true;
      });

      ///get Auth Token
      await wordPress.authenticateUser(
        username: 'brodyras',
        password: 'Rasmussen779',
      );

      //TODO: figure out how to stop registering w the same email...
/*      bool success = */
      await wordPress
          .createUser(
              user: User(
                  email: email,
                  password: password,
                  username: name,
                  roles: ['subscriber']))
          .then((p) async {
        print('User created successfully $p');
        User user = await wordPress.fetchUser(username: name, email: email);
        Singleton().user = user;
        Singleton().cachedPosts[HumanReadableCategories.videos] =
            new List<PostSkel>();
        Singleton().cachedPosts[HumanReadableCategories.quotes] =
            new List<PostSkel>();
        Singleton().cachedPosts[HumanReadableCategories.education] =
            new List<PostSkel>();
        Singleton().cachedPosts[HumanReadableCategories.recipes] =
            new List<PostSkel>();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Root()));
      }).catchError((WordPressError err) {
        setState(() {
          isLoading = false;
        });
        print('Failed to create user: $err');
        //TODO: alert user if failed to create user
      });
    }
  }
}
