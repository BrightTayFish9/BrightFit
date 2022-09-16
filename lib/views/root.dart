import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/presentation/bright_fit_icons.dart';
import 'package:bright_fit/views/home.dart';
import 'package:bright_fit/views/profile.dart';
import 'package:bright_fit/views/profile_settings.dart';
import 'package:bright_fit/views/progress.dart';
import 'package:bright_fit/views/workout.dart';
import 'package:flutter/material.dart';
import 'glossary.dart';

///Holds the 5 main pages and BottomNavBar
class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int bottomSelectedIndex = 0;
  TextStyle bnbStyle = TextStyle(fontSize: 20);

  final String _title = "BRIGHT FITNESS";
  final String _homeLabel = 'HOME';
  final String _glossaryLabel = 'GLOSSARY';
  final String _workoutLabel = 'WORKOUT';
  final String _progressLabel = 'PROGRESS';
  final String _profileLabel = 'PROFILE';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _title,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline2.fontSize),
          ),
          actions: <Widget>[
            ///Shows settings option only from profile page
            Opacity(
              opacity: bottomSelectedIndex == 4 ? 1.0 : 0.0,
              child: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: bottomSelectedIndex != 4
                      ? null
                      : () {
                          if (bottomSelectedIndex == 4) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileSettings()));
                          }
                        },
                ),
              ),
            )
          ],
        ),
        body: buildPageView(),
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: IconThemeData(
            color: Singleton().model.color,
          ),
          fixedColor: Singleton().model.color,
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            bottomTapped(index);
          },
          items: buildBottomNavBarItems(),
        ),
      ),
    );
  }

  Widget appBarItem(Icon icon, Text text) {
    return Column(
      children: <Widget>[icon, text],
    );
  }

  List<Widget> buildAppBarItems() {
    double iconSize = 40;

    return [
      appBarItem(
          Icon(
            BrightFitIcons.home,
            size: iconSize,
          ),
          Text(
            _homeLabel,
            style: bnbStyle,
          )),
      appBarItem(
          Icon(
            BrightFitIcons.glossary,
            size: iconSize,
          ),
          Text(
            _glossaryLabel,
            style: bnbStyle,
          )),
      appBarItem(
          Icon(
            BrightFitIcons.workout,
            size: iconSize + 10,
          ),
          Text(
            _workoutLabel,
            style: TextStyle(fontSize: 20),
          )),
      appBarItem(
          Icon(
            BrightFitIcons.graph,
            size: iconSize,
          ),
          Text(
            _progressLabel,
            style: bnbStyle,
          )),
      appBarItem(
          Icon(
            BrightFitIcons.profile,
            size: iconSize,
          ),
          Text(
            _profileLabel,
            style: bnbStyle,
          )),
    ];
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    double iconSize = 40;
    return [
      BottomNavigationBarItem(
          icon: Icon(
            BrightFitIcons.home,
            size: iconSize,
          ),
          label: _homeLabel),
      BottomNavigationBarItem(
          icon: Icon(
            BrightFitIcons.glossary,
            size: iconSize,
          ),
          label: _glossaryLabel),
      BottomNavigationBarItem(
          icon: Icon(
            BrightFitIcons.workout,
            size: iconSize + 10,
          ),
          label: _workoutLabel),
      BottomNavigationBarItem(
          icon: Icon(
            BrightFitIcons.graph,
            size: iconSize,
          ),
          label: _progressLabel),
      BottomNavigationBarItem(
          icon: Icon(
            BrightFitIcons.profile,
            size: iconSize,
          ),
          label: _profileLabel),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Home(),
        Glossary(),
        Workout(),
        Progress(),
        Profile(() => setNavState())

        ///^^this is passed, so the nav bar will set state when the color is updated
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  //TODO: this feels sloppy, but it works...?
  void setNavState() {
    setState(() {});
  }
}
