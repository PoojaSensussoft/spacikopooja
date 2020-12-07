import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spacikopooja/login/Login.dart';

void main() => runApp(Splash());

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpalshScreen(),
    );
  }
}

class SpalshScreen extends StatefulWidget {
  @override
  _SlashScreenState createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Login())
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage('image/splash.jpg')),
      ),
    );
  }
}
