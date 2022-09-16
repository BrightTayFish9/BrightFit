import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/wp_category.dart';
import 'package:flutter/material.dart';

import 'library_rack.dart';

///Displays all old posts
class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  int bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIBRARY',
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline2.fontSize),
        ),
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
    );
  }

  TextStyle bnbStyle = TextStyle(fontSize: 20);

  final String _videoLabel = 'OLD VIDEOS';
  final String _quoteLabel = 'OLD QUOTES';
  final String _educationLabel = 'OLD EDUCATION';
  final String _recipeLabel = 'OLD RECIPES';

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    double iconSize = 40;
    return [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.videocam,
            size: iconSize,
          ),
          label: _videoLabel),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.sort_by_alpha,
            size: iconSize,
          ),
          label: _quoteLabel),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.book,
            size: iconSize,
          ),
          label: _educationLabel),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.fastfood,
            size: iconSize,
          ),
          label: _educationLabel),
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
      //TODO: skipping from first to last leaves the middle pages unpopulated... fix?
      children: <Widget>[
        LibraryRack('OLD VIDEOS', WPCategoryCodes.video),
        LibraryRack('OLD QUOTES', WPCategoryCodes.quote),
        LibraryRack('OLD EDUCATION', WPCategoryCodes.education),
        LibraryRack('OLD RECIPES', WPCategoryCodes.recipe),
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
}
