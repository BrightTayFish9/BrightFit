import 'dart:convert';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:bright_fit/widgets/post_grid.dart';
import 'package:bright_fit/widgets/weighter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Show all previous Video, Quote, Education, and Recipe posts
class LibraryRack extends StatefulWidget {
  final String _title;
  final int _category;

  LibraryRack(this._title, this._category);

  @override
  _LibraryRackState createState() => _LibraryRackState();
}

class _LibraryRackState extends State<LibraryRack> {
  bool isLoading = false;
  bool lastPageFound = false;

  @override
  Widget build(BuildContext context) {
    isLoading = false;

    return Singleton().cachedPosts[widget._title] == null
        ? FutureBuilder(
            future: _loadData(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) {}
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Weighter());
              }
              return PostGrid(widget._title, _loadData, isLoading);
            })
        : PostGrid(widget._title, _loadData, isLoading);
  }

  Future _loadData() async {
    const int PAG_LIMIT = 20;
    if (!lastPageFound) {
      if (Singleton().cachedPosts[widget._title] == null) {
        Singleton().cachedPosts[widget._title] = new List<PostSkel>();
      }
      List<PostSkel> list = Singleton().cachedPosts[widget._title];
      int last = 0;
      if (list.length > 0) {
        last = list.last.id;
      }
      var response = await http
          .get('https://brightontaylorfitness.com/wp-json/bf/v1/get_posts_cat'
              '/cat=${widget._category}'
              '/last=$last');
      var newPosts = (json.decode(response.body) as List)
          .map((e) => PostSkel.fromJson(e))
          .toList();
      if (newPosts.length < PAG_LIMIT) lastPageFound = true;
      setState(() {
        Singleton singleton = Singleton();
        singleton.cachedPosts[widget._title].addAll(newPosts);
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
