import 'dart:convert';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:bright_fit/views/camera_view.dart';
import 'package:bright_fit/widgets/post_grid.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Displays all saved posts in a Rack
class Rack extends StatefulWidget {
  final String _title;

  Rack(this._title);

  @override
  _RackState createState() => _RackState();
}

class _RackState extends State<Rack> {
  bool isLoading = false;
  bool lastPageFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget._title,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline2.fontSize),
        ),
      ),
      body: PostGrid(widget._title, _loadData, isLoading),

      ///PHOTO JOURNAL BUTTON
      ///allows for a new post to be made if the user is in the Photo Journal Rack
      floatingActionButton: Container(
        width: 100,
        height: 100,
        child: widget._title != 'PHOTO JOURNAL'
            ? null
            : FloatingActionButton(
                backgroundColor: Singleton().model.color,
                elevation: 10,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () async {
                  debugPrint('camera tapped');
                  WidgetsFlutterBinding.ensureInitialized();
                  final cameras = await availableCameras();
                  final firstCamera = cameras.first;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraView(
                                camera: firstCamera,
                                from: 'rack',
                              )));
                },
              ),
      ),
    );
  }

  Future _loadData() async {
    const int PAG_LIMIT = 20;
    if (!lastPageFound) {
      var response = await http
          .get('https://brightontaylorfitness.com/wp-json/bf/v1/get_posts_pag'
              '/userid=${Singleton().user.id}'
              '/cat=${Singleton().cachedPosts[widget._title][0].categoryID}'
              '/last=${Singleton().cachedPosts[widget._title].last.id}');
      var newPosts = (json.decode(response.body) as List)
          .map((e) => PostSkel.fromJson(e))
          .toList();
      if (newPosts.length < PAG_LIMIT) lastPageFound = true;
      setState(() {
        Singleton().cachedPosts[widget._title].addAll(newPosts);
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
