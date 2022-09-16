import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/controllers/snackbar_controller.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:bright_fit/views/rack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///Displays the 5 most recently saved posts of a given Rack
class RackTeaser extends StatefulWidget {
  final String _title;

  RackTeaser(this._title);

  @override
  _RackTeaserState createState() => _RackTeaserState();
}

class _RackTeaserState extends State<RackTeaser> {
  double width, height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    width = size.width - 30;
    height = width / 2;

    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ///DIVIDER
          SizedBox(height: 10),
          Divider(color: Singleton().model.color),

          ///TITLE
          Align(alignment: Alignment.centerLeft, child: Text(widget._title)),

          ///IMAGES
          InkWell(
            onTap: () async {
              if (Singleton().cachedPosts[widget._title].length == 0) {
                SnackBarController.show('no racks to show!', context, 3);
              } else {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Rack(widget._title)));

                ///alert system and user if a post has been deleted
                if (result == 'true') {
                  setState(() {});
                  SnackBarController.show(
                      'post removed from ${widget._title} rack', context, 3);
                }
              }
            },
            child: Row(
              children: <Widget>[
                jigsawImages(Singleton().cachedPosts[widget._title]),
              ],
            ),
          )
        ],
      ),
    );
  }

  cachedImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
    );
  }

  jigsawImages(List<PostSkel> posts) {
    return Container(
      height: height,
      child: Row(
        children: <Widget>[
          posts.length > 0 ? wideCard(posts[0], 5) : wideCard(null, 5),
          Column(
            children: <Widget>[
              posts.length > 1 ? teaserCard(posts[1], 2) : teaserCard(null, 2),
              posts.length > 2 ? teaserCard(posts[2], 3) : teaserCard(null, 3),
            ],
          ),
          Column(
            children: <Widget>[
              posts.length > 3 ? teaserCard(posts[3], 3) : teaserCard(null, 3),
              posts.length > 4 ? teaserCard(posts[4], 2) : teaserCard(null, 2),
            ],
          ),
        ],
      ),
    );
  }

  Card teaserCard(PostSkel post, int ratio) {
    return Card(
      elevation: 2,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
          height: height * ratio / 5 - 8,
          width: width / 4 - 8,
          child: post == null
              ? Container(color: Colors.grey.shade300)
              : cachedImage(post.imageURL)),
    );
  }

  Card wideCard(PostSkel post, int ratio) {
    return Card(
      elevation: 2,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
          height: height * ratio / 5 - 8,
          width: height * ratio / 5 - 8,
          child: post == null
              ? Container(color: Colors.grey.shade300)
              : cachedImage(post.imageURL)),
    );
  }
}
