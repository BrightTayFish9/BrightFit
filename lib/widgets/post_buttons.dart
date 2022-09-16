import 'dart:convert';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/controllers/snackbar_controller.dart';
import 'package:bright_fit/models/human_readable_categories.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Manages saving / deleting posts from rack
class PostButtons extends StatefulWidget {
  final PostSkel _post;

  PostButtons(this._post);

  @override
  _PostButtonsState createState() => _PostButtonsState();
}

class _PostButtonsState extends State<PostButtons> {
  final Icon emptyStar = Icon(
    Icons.star_border,
    color: Singleton().model.color,
  );

  final Icon fullStar = Icon(
    Icons.star,
    color: Singleton().model.color,
  );

  @override
  Widget build(BuildContext context) {
    String category = widget._post.categoryName;
    String cat = HumanReadableCategories.parse(category);
    bool isFavorited = Singleton()
        .cachedPosts[cat]
        .map((e) => e.id)
        .toList()
        .contains(widget._post.id);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Opacity(
          opacity: isFavorited ? 1.0 : 0.0,
          child: TextButton(
            onPressed: !isFavorited
                ? null
                : () {
                    print('trashed tapped');
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text(
                                'DELETE',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                    color: Singleton().model.color),
                              ),
                              content: Text(
                                'Are you sure you want to remove this rack?'
                                    .toUpperCase(),
                                style: TextStyle(fontSize: 30),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.grey.shade500),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'YES',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30,
                                        color: Singleton().model.color),
                                  ),
                                  onPressed: () async {
                                    int userid = Singleton().user.id;
                                    int postid = widget._post.id;
                                    http.delete(
                                      'https://brightontaylorfitness.com/wp-json/bf/v1/del_fav/userid=$userid/postid=$postid',
                                    );

                                    Singleton().cachedPosts[cat].removeWhere(
                                        (fav) => fav.id == widget._post.id);
                                    //TODO: ensure profile page sets State, and snack bar is shown
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                  },
                                ),
                              ],
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                        barrierDismissible: true);
                  },
            child: Icon(
              Icons.delete,
              color: Singleton().model.color,
            ),
          ),
        ),
        Builder(
          builder: (context) => TextButton(
              onPressed: isFavorited
                  ? null
                  : () {
                      http.post(
                          'https://brightontaylorfitness.com/wp-json/bf/v1/post_fav',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, dynamic>{
                            'userid': Singleton().user.id,
                            'postid': widget._post.id,
                            'category': widget._post.categoryID,
                            'timestamp': DateTime.now().toString()
                          }));
                      SnackBarController.show(
                          'Added to ${widget._post.categoryName.split(' ')[0]} rack',
                          context,
                          3);
                      setState(() {
                        if (!Singleton()
                            .cachedPosts[cat]
                            .contains(widget._post)) {
                          Singleton().cachedPosts[cat].insert(0, widget._post);
                        }
                      });
                    },
              child: isFavorited ? fullStar : emptyStar),
        ),
      ],
    );
  }
}
