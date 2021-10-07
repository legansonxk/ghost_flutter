import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../author/author.dart';
import '../home/home.dart';
import '../tag/tag.dart';

var tabs = [HomeScreen(), TagScreen(), AuthorScreen()];

class TabScreen extends StatefulWidget {
  @override
  _StateTabScreen createState() => _StateTabScreen();
}

class _StateTabScreen extends State<TabScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (value) {
            setState(() {
              tabIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.tags,
              ),
              label: 'Tags'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person_2_square_stack,
              ),
              label: 'Authors'
            )
          ]),
    );
  }
}
