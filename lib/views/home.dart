import 'dart:convert';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:bright_fit/widgets/home_post_widget.dart';
import 'package:bright_fit/widgets/library_teaser.dart';
import 'package:bright_fit/widgets/weighter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Displays the four most recent posts, as well as access to the Library
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<PostSkel>> _fetchPosts() async {
    var response = await http
        .get('https://brightontaylorfitness.com/wp-json/bf/v1/get_week');

    var posts = (json.decode(response.body) as List)
        .map((e) => PostSkel.fromJson(e))
        .toList();

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Singleton().cachedPosts['HOME POSTS'] == null
          ? FutureBuilder(
              future: _fetchPosts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PostSkel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.hasData == null) {}
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Weighter();
                }
                Singleton().cachedPosts['HOME POSTS'] = snapshot.data;
                return getListView();
              })
          : getListView(),
    );
  }

  Widget getListView() {
    List _colors = [
      Colors.grey.shade800,
      Colors.grey.shade700,
      Colors.grey.shade600,
      Colors.grey.shade500,
    ];

    return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          if (index < 4) {
            return HomePostWidget(
                Singleton().cachedPosts['HOME POSTS'][index], _colors[index]);
          } else {
            return LibraryTeaser(_colors[0]);
          }
        });
  }
}
