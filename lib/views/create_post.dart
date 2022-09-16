import 'dart:io';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:flutter/material.dart';

///Provide a description to go with your photo journal, and post it
class CreatePost extends StatefulWidget {
  final String _path;

  CreatePost(this._path);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BRIGHT FITNESS',
          style: TextStyle(fontSize: Theme.of(context).textTheme.headline2.fontSize),
        ),
      ),
      body: GestureDetector(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              ///IMAGE
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .6,
                  child: Image.file(
                    File(widget._path),
                    fit: BoxFit.cover,
                  )),
              Column(
                children: <Widget>[
                  ///INFO
                  Text(
                    'NEW PHOTO JOURNAL',
                    style: TextStyle(fontSize: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.grey.shade700),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            style: TextStyle(fontSize: 40),
                            controller: controller,
                            onChanged: (value) {
                              controller.value = TextEditingValue(
                                  text: value.toUpperCase(),
                                  selection: controller.selection);
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: send post to WordPress, update local photo journal
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        backgroundColor: Singleton().model.color,
        child: Icon(
          Icons.create,
          color: Colors.white,
        ),
      ),
    );
  }
}
