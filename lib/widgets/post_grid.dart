import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/views/post_view.dart';
import 'package:bright_fit/widgets/small_weighter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///Used to show all saved posts in a rack, or old posts from the library
class PostGrid extends StatefulWidget {
  final String _title;
  final Function _loadData;
  bool _isLoading;

  PostGrid(this._title, this._loadData, this._isLoading);

  @override
  _PostGridState createState() => _PostGridState();
}

class _PostGridState extends State<PostGrid> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              if (!widget._isLoading) {
                widget._loadData();
                setState(() {
                  widget._isLoading = true;
                });
              }
            }
            return false;
          },
          child: Container(
            child: GridView.builder(
                itemCount: Singleton().cachedPosts[widget._title].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return generateGridCard(context, index);
                }),
          ),
        ),
        Opacity(
          opacity: widget._isLoading ? 1.0 : 0.0,
          child: SmallWeighter(),
        )
      ],
    );
  }

  InkWell generateGridCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        debugPrint(
            '${Singleton().cachedPosts[widget._title][index].title} tapped');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PostView(Singleton().cachedPosts[widget._title][index])));
      },
      child: Card(
        elevation: 4.0,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          imageUrl: Singleton().cachedPosts[widget._title][index].imageURL,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
