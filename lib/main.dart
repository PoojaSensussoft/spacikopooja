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


   /*generate JKS*/

// mac@macs-iMac-2 spacikopooja % keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
// Enter keystore password:
// Re-enter new password:
// What is your first and last name?
// [Unknown]:  test
// What is the name of your organizational unit?
// [Unknown]:  test
// What is the name of your organization?
// [Unknown]:  test
// What is the name of your City or Locality?
// [Unknown]:  Surat
// What is the name of your State or Province?
// [Unknown]:  Gujarat
// What is the two-letter country code for this unit?
// [Unknown]:  +91
// Is CN=test, OU=test, O=test, L=Surat, ST=Gujarat, C="+91" correct?
// [no]:  yes