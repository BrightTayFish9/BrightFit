import 'dart:convert';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/controllers/snackbar_controller.dart';
import 'package:bright_fit/models/human_readable_categories.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:bright_fit/models/progress_series.dart';
import 'package:bright_fit/views/register.dart';
import 'package:bright_fit/views/root.dart';
import 'package:bright_fit/widgets/small_weighter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:http/http.dart' as http;

///Logs in existing WP users, or offers Registration for new users
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var isLoading = false;

  getTextTheme() {
    return TextTheme(
      bodyText2: TextStyle(fontSize: 40),
      bodyText1: TextStyle(fontSize: 35),
      headline1: TextStyle(fontSize: 50),
      headline2: TextStyle(fontSize: 45),
      headline3: TextStyle(fontSize: 40),
      headline4: TextStyle(fontSize: 50),
      headline5: TextStyle(fontSize: 50),
      headline6: TextStyle(fontSize: 50),
      subtitle1: TextStyle(fontSize: 40),
      subtitle2: TextStyle(fontSize: 40),
    );
  }

  ThemeData getMainTheme() {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.grey,
        fontFamily: 'chump_change',
        textTheme: getTextTheme(),
        appBarTheme: AppBarTheme(
          elevation: 8,
        ),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: TextStyle(
          fontFamily: 'chump_change',
          fontSize: 30,
        )));
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextField usernameField = TextField(
      enabled: !isLoading,
      controller: usernameController,
      decoration: InputDecoration(
        hintText: 'USERNAME',
        border: OutlineInputBorder(borderSide: BorderSide(width: 5.0)),
      ),
    );
    TextField passwordField = TextField(
      enabled: !isLoading,
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'PASSWORD',
        border: OutlineInputBorder(borderSide: BorderSide(width: 5.0)),
      ),
    );

    //TODO: obviously for debugging, remove eventually!!!
    usernameController.text = 'brodyras';
    passwordController.text = 'Rasmussen779';

    return MaterialApp(
      theme: getMainTheme(),
      home: Builder(
        builder: (context) => Scaffold(
          body: ListView(
            children: [
              ///IMAGE
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  width: 250.0,
                  child: Image.asset('assets/images/BFlogo.png'),
                ),
              ),

              ///FORMS
              Center(child: Container(width: 300, child: usernameField)),
              SizedBox(height: 10),
              Center(child: Container(width: 300, child: passwordField)),

              ///BUTTONS
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Builder(
                      builder: (context) => ElevatedButton(
                          child: Text(
                            'LOG IN',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          onPressed: !isLoading ? () => _login(context) : null),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      onPressed: !isLoading
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterView()));
                            }
                          : null,
                    ),
                  ],
                ),
              ),
              Opacity(
                opacity: isLoading ? 1.0 : 0.0,
                child: SmallWeighter(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    WordPress wordPress = WordPress(
        baseUrl: 'https://brightontaylorfitness.com/',
        authenticator: WordPressAuthenticator.JWT);

    User user;

    ///Handle incorrect credentials
    try {
      user = await wordPress.authenticateUser(
        username: usernameController.text,
        password: passwordController.text,
      );
    } on WordPressError catch (_) {
      SnackBarController.show('login not recognized', context, 3);
      setState(() {
        isLoading = false;
      });
    }

    ///Only proceed if valid credentials are given
    if (user != null) {
      Singleton().user = user;

      await _populateSingleton();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Root()));
    }
  }

  Future _populateSingleton() async {
    Singleton singleton = Singleton();

    ///Obtain all the saved posts of the logged user
    for (int i = 0; i < HumanReadableCategories.labels.length; i++) {
      var response = await http.get(
          'https://brightontaylorfitness.com/wp-json/bf/v1/get_posts_pag'
          '/userid=${Singleton().user.id}'
          '/cat=${HumanReadableCategories.mappedLabels[HumanReadableCategories.labels[i]]}'
          '/last=0',
          headers: {'Cache-Control': 'no-cache'});

      var posts = (json.decode(response.body) as List)
          .map((e) => PostSkel.fromJson(e))
          .toList();

      singleton.cachedPosts[HumanReadableCategories.labels[i]] = posts;
    }

    ///Create empty lists for progress, so there's no null issues later
    singleton.cachedProgress["WEIGHT"] = new List<ProgressSeries>();
    singleton.cachedProgress["BENCH"] = new List<ProgressSeries>();
    singleton.cachedProgress["SHOULDER PRESS"] = new List<ProgressSeries>();
    singleton.cachedProgress["BICEP CURL"] = new List<ProgressSeries>();
    singleton.cachedProgress["BACK SQUAT"] = new List<ProgressSeries>();
    singleton.cachedProgress["FRONT SQUAT"] = new List<ProgressSeries>();
    singleton.cachedProgress["DEAD LIFT"] = new List<ProgressSeries>();
  }
}
