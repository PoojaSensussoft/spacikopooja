import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility{
  static int CURRENT_STEP = 0;

  static String USER_EMAIL = 'user_email';
  static String USER_NAME = 'user_name';

  static showToast(String message){
    Fluttertoast.showToast(
      fontSize: 14,
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white
    );
  }
}