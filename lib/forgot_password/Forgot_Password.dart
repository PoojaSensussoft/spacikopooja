import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacikopooja/Database/database_helper.dart';
import 'package:spacikopooja/login/Login.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/Validation.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'package:sqflite/sqflite.dart';


class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController contorl_email = TextEditingController();
  TextEditingController old_password = TextEditingController();
  TextEditingController new_password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;

  SharedPreferences prefs;
  Database db;

  Future<void> dbInit() async {
    prefs = await SharedPreferences.getInstance();
    db = await DatabaseHelper.instance.database;
  }

  @override
  void initState() {
    dbInit();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        /*for backgorud*/
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('image/login.png'), fit: BoxFit.fill),
        ),

        child: SingleChildScrollView(
          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                /*logo*/
                Container(
                  margin: EdgeInsets.only(top: 100),
                  height: 110,
                  child: Image(
                    image: AssetImage('image/logo.png'),
                  ),
                ),

                /*email*/
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: EdgeInsets.only(top: 35),

                  child: Theme(
                    data: new ThemeData(
                      primaryColor: spacikoColor.ColorPrimary,
                      primaryColorDark: spacikoColor.ColorPrimary,
                    ),

                    child: TextFormField(
                      controller: contorl_email,
                      cursorColor: spacikoColor.ColorPrimary,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: spacikoColor.ColorPrimary)),
                      ),

                      validator: (text) {
                        if (Validation.isValidEmail(text)) {
                          return 'Enter Valid Email';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                ),

                /*password*/
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: EdgeInsets.only(top: 18),

                  child: Theme(
                    data: new ThemeData(
                      primaryColor: spacikoColor.ColorPrimary,
                      primaryColorDark: spacikoColor.ColorPrimary,
                    ),

                    child: TextFormField(
                      obscureText: true,
                      controller: old_password,
                      cursorColor: spacikoColor.ColorPrimary,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(

                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "New Password",
                        labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),


                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                      ),

                      validator: (text) {
                        if (Validation.isPasswordValid(text)) {
                          return 'Password must be 6 char long';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),


                /*password*/
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: EdgeInsets.only(top: 18),

                  child: Theme(
                    data: new ThemeData(
                      primaryColor: spacikoColor.ColorPrimary,
                      primaryColorDark: spacikoColor.ColorPrimary,
                    ),

                    child: TextFormField(
                      obscureText: true,
                      controller: new_password,
                      cursorColor: spacikoColor.ColorPrimary,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(

                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "confirm Password",
                        labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                      ),

                      validator: (text) {
                        if (Validation.isPasswordValid(text)) {
                          return 'Password must be 6 char long';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),



                /*login button*/
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 52,
                  margin: EdgeInsets.only(left: 25, right: 25, top: 50),
                  child: RaisedButton(
                    color: spacikoColor.ColorPrimary,

                    child: Text("Forgot password", style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite),),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),

                    onPressed: () async {
                      if(_formKey.currentState.validate()){

                        List<Map> result1 = await db.rawQuery('SELECT * FROM my_table WHERE email=?',[contorl_email.text]);
                        print('result:::$result1');
                        print('result11:::$contorl_email.text');

                        if(result1.length!=0){
                          if(old_password.text == new_password.text) {
                            result1.forEach((row) {
                              _update(row['app_id'], row['fname'], row['lname'], row['email'],
                                  new_password.text, row['ischeck'], 'email', row['id']);
                            });

                          }else{
                            Utility.showToast("Password does not match!");
                          }

                        }else{
                          Utility.showToast("Email id not exist");
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),


      ),
    );
  }

  void _update(String columnID, String f_name, String l_name, String email, String password,
      String ischeck, String login_with, int item_id) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnAppId : columnID,
      DatabaseHelper.columnFName : f_name,
      DatabaseHelper.columnLName  : l_name,
      DatabaseHelper.columnEmail : email,
      DatabaseHelper.columnPassword : password,
      DatabaseHelper.columnIscheck : ischeck,
      DatabaseHelper.columnLoginwith : login_with,
    };

    final id = await dbHelper.updateItem(row, item_id);
    print('updated_ROW:::::: $id');
    Utility.showToast("Password Updated Successfully!");

    Future.delayed(Duration(milliseconds: 50), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    });
  }

}
