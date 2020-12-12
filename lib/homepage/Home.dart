import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/NewAddNav.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'layouts/CalenderNav.dart';
import 'layouts/chatSection/ChatScreenNav.dart';
import 'layouts/CompassNav.dart';
import '../utils/CustomBottomNav.dart';
import 'layouts/UserProfileNav.dart';

void main() => runApp(Home());


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
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
    var screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: spacikoColor.ColorPrimary,
          ),
        ),

        /*set layout position*/
        body: _widgetOptions.elementAt(_selectedIndex),


        /*set bottom navigation*/
        bottomNavigationBar: SafeArea(
          top: true,
          bottom: true,
          child: CustomBottomNav(onChange: (val){
            setState(() {
              _selectedIndex = val;
            });
          },),
        )

      ),
    );
  }


  /*list of layouts*/
  List<Widget> _widgetOptions = <Widget>[
    Container(
      child: CompassNav(),
    ),

    Container(
      child: CalenderNav(),
    ),

    Container(
      child: NewAddNav(),
    ),

    Container(
      child: ChatScreenNav(),
    ),

    Container(
      child: UserProfile(),
    ),
  ];
}
