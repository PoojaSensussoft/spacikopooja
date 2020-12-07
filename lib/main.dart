import 'package:flutter/material.dart';
import 'package:spacikopooja/splashscreen/SplashScreen.dart';

import 'login/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Splash(),
    );
  }
}