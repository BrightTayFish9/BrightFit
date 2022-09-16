import 'package:bright_fit/models/exercise_model.dart';
import 'package:bright_fit/views/exercise_view.dart';
import 'package:bright_fit/widgets/weighter.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

///Shown in Glossary to lead to the full Exercise view
class ExerciseCard extends StatefulWidget {
  final ExerciseModel _model;

  ExerciseCard(this._model);

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ExerciseView(widget._model)));
        },
        child: Card(
          elevation: 8.0,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: <Widget>[
              Text(widget._model.title.toUpperCase()),
              Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: FutureBuilder(
                    future: VideoThumbnail.thumbnailData(
                      video: widget._model.link,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none &&
                          snapshot.hasData == null) {}
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Weighter();
                      }
                      //TODO: find a way to cache?
                      return Container(
                        width: MediaQuery.of(context).size.width - 8,
                        child: Image.memory(
                          snapshot.data,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
