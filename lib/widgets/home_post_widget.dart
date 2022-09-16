import 'package:bright_fit/models/post_skel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bright_fit/views/post_view.dart';

///Displays the most recent Video, Quote, Education, and Recipe on Home Page
class HomePostWidget extends StatelessWidget {
  final PostSkel _post;
  final Color _color;

  HomePostWidget(this._post, this._color);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery
        .of(context)
        .size
        .height / 4;
    double cardWidth = MediaQuery
        .of(context)
        .size
        .width;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PostView(_post)));
      },
      child: Container(
        height: cardHeight,
        width: cardWidth,
        child: Card(
          elevation: 4.5,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            child: Stack(
              children: <Widget>[

                ///IMAGE
                Align(
                  alignment: Alignment.centerRight,
                  child: CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 500),
                    imageUrl: _post.imageURL,
                    fit: BoxFit.cover,
                    width: cardWidth * (3 / 4),
                    placeholder: (context, url) =>
                        Container(
                          child: Center(child: CircularProgressIndicator()
                          ),
                        ),
                  ),
                ),

                ///TRAPEZOID
                Container(
                  child: CustomPaint(
                    size: Size(cardWidth /2, cardHeight),
                    painter: DrawTrapezoid(_color),
                  ),
                ),

                ///TEXT
                Container(
                  width: cardWidth * (2/5),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    _post.categoryName.toUpperCase(),
                    style: TextStyle(
                      fontSize: cardWidth / 10,
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawTrapezoid extends CustomPainter {
  Paint _paint;

  DrawTrapezoid(Color color) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * .70, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
