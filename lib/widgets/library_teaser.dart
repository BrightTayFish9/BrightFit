import 'package:bright_fit/views/library.dart';
import 'package:flutter/material.dart';

///Directs user to the Library, where old posts are displayed
class LibraryTeaser extends StatelessWidget {
  final Color _color;

  LibraryTeaser(this._color);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery
        .of(context)
        .size
        .height / 8;
    double cardWidth = MediaQuery
        .of(context)
        .size
        .width;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Library()));
      },
      child: Container(
        height: cardHeight,
        width: cardWidth,
        child: Card(
          elevation: 4.5,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            color: _color,
            child: Container(
              width: cardWidth * (2/5),
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text(
                'SEE OLDER POSTS',
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}