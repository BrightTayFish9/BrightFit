import 'dart:convert';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/exercise_model.dart';
import 'package:bright_fit/widgets/exercise_card.dart';
import 'package:bright_fit/widgets/small_weighter.dart';
import 'package:bright_fit/widgets/weighter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Shows a list of exercise teasers associated with the selected muscle group
class GlossaryList extends StatefulWidget {
  final String _title;

  GlossaryList(this._title);

  @override
  _GlossaryListState createState() => _GlossaryListState();
}

class _GlossaryListState extends State<GlossaryList> {
  bool isLoading = false;
  bool lastPageFound = false;

  @override
  void initState() {
    super.initState();
    if (Singleton().cachedExercises[widget._title] == null) _fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget._title + " EXERCISES",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline2.fontSize),
          ),
        ),
        body: Singleton().cachedExercises[widget._title] == null ||
                Singleton().cachedExercises[widget._title].length == 0
            ? Center(child: Weighter())
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: getListView()));
  }

  Widget getListView() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              if (!isLoading && !lastPageFound) {
                _fetchExercises();
                setState(() {
                  isLoading = true;
                });
              }
            }
            return false;
          },
          //TODO: stop rebuilding the previous images...?
          child: ListView.builder(
              itemCount: Singleton().cachedExercises[widget._title].length,
              itemBuilder: (context, index) {
                Singleton singleton = Singleton();
                ExerciseModel model =
                    singleton.cachedExercises[widget._title][index];
                print(model.link);
                return ExerciseCard(model);
              }),
        ),

        ///Hide the loader when no request is being processed
        Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: SmallWeighter(),
        )
      ],
    );
  }

  Future _fetchExercises() async {
    const int PAG_LIMIT = 20;
    String last;

    ///Ensure the list isn't null
    if (Singleton().cachedExercises[widget._title] == null) {
      Singleton().cachedExercises[widget._title] = new List<ExerciseModel>();
      last = "0";
    } else {
      last = Singleton().cachedExercises[widget._title].last.title;
    }

    ///Only make request if we know there's more to be found
    if (!lastPageFound) {
      var response = await http.get(
          'https://brightontaylorfitness.com/wp-json/bf/v1/get_exercises_group'
          '?group="${widget._title}"'
          '&last="$last"');
      var newExercises = (json.decode(response.body) as List)
          .map((e) => ExerciseModel.fromJson(e))
          .toList();
      if (newExercises.length < PAG_LIMIT) lastPageFound = true;
      setState(() {
        Singleton().cachedExercises[widget._title].addAll(newExercises);
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
