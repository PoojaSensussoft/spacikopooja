import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/NewAddNav.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import 'layouts/AddNav.dart';
import 'layouts/CalenderNav.dart';
import 'layouts/CommentNav.dart';
import 'layouts/CompassNav.dart';
import '../utils/CustomBottomNav.dart';
import 'layouts/UserProfileNav.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: spacikoColor.ColorPrimary,
          ),
        ),

        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        /*set layout position*/
        body: _widgetOptions.elementAt(_selectedIndex),

        /*set bottom navigation*/
        bottomNavigationBar: SafeArea(
          bottom: true,
          child: CustomBottomNav(
          onChange: (val) {
            setState(() {
              _selectedIndex = val;
              print(_selectedIndex);
            });
          },
        ),
        ),
      ),
    );
  }


  /*list of layouts*/
  List<Widget> _widgetOptions = <Widget>[
    Container(
      // child: CompassNav(),
      child: CompassNav(),
    ),

    Container(
      child: CalenderNav(),
    ),

    Container(
      child: NewAddNav(),
    ),

    Container(
      child: Comment(),
    ),

    Container(
      child: UserProfile(),
    ),
  ];
}
