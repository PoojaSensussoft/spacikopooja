import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/login/Login.dart';
import 'package:spacikopooja/terms_cond/TermsAndcond.dart';
import 'package:spacikopooja/utils/Validation.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import '../introscreen/FirstIntroScreen.dart';

class Register extends StatefulWidget {
  String email;
  String password;

  Register(String email, String password) {
    this.email = email;
    this.password = password;
  }

  @override
  _RegisterState createState() => _RegisterState(email, password);
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool checkboxValue = false;

  String get_email;
  String get_password;

  _RegisterState(String email, String password) {
    this.get_email = email;
    this.get_password = password;
  }

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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          /*for background*/
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('image/login.png'), fit: BoxFit.fill),
          ),

          /*scroll*/
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20, bottom: 20),

            /*start form*/
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /*logo*/
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    height: 135,
                    child: Image(
                      image: AssetImage('image/logo.png'),
                    ),
                  ),

                  /*first Row*/
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        /*first name*/
                    Flexible(
                         child: Container(margin: EdgeInsets.only(top: 35, left: 20,right: 7),

                          child: Theme(
                            data: new ThemeData(
                              primaryColor: spacikoColor.ColorPrimary,
                              primaryColorDark: spacikoColor.ColorPrimary,
                            ),

                            child: TextFormField(
                              //controller: email,
                              cursorColor: spacikoColor.ColorPrimary,
                              keyboardType: TextInputType.text,

                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20),
                                labelText: "First Name",
                                labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: spacikoColor.ColorPrimary)),
                              ),

                              validator: (text) {
                                if (Validation.isNameEmpty(text)) {
                                  return 'Enter First Name';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                    ),


                        /*last name*/
                        Flexible(
                          child: Container(margin: EdgeInsets.only(top: 35,left: 7,right: 20),
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: spacikoColor.ColorPrimary,
                              primaryColorDark: spacikoColor.ColorPrimary,
                            ),

                            child: TextFormField(
                              cursorColor: spacikoColor.ColorPrimary,
                              keyboardType: TextInputType.text,

                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20),
                                labelText: "Last Name",
                                labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: spacikoColor.ColorPrimary)),
                              ),

                              validator: (text) {
                                if (Validation.isNameEmpty(text)) {
                                  return 'Enter Last Name';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        )
                        )
                      ],
                    ),


                  /*email*/
                  Container(
                    margin: EdgeInsets.only(top: 18,left: 20, right: 20),

                    child: Theme(
                      data: new ThemeData(
                        primaryColor: spacikoColor.ColorPrimary,
                        primaryColorDark: spacikoColor.ColorPrimary,
                      ),

                      child: TextFormField(
                        initialValue: get_email,
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
                    margin: EdgeInsets.only(top: 18,left: 20, right: 20),

                    child: Theme(
                      data: new ThemeData(
                        primaryColor: spacikoColor.ColorPrimary,
                        primaryColorDark: spacikoColor.ColorPrimary,
                      ),

                      child: TextFormField(
                        initialValue: get_password,
                        obscureText: true,
                        cursorColor: spacikoColor.ColorPrimary,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.only(left: 20),
                          labelText: "Password",
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


                  /*set terms&cond*/
                  Container(
                    margin: EdgeInsets.only(top: 15,left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              checkboxValue = !checkboxValue;
                            });
                          },
                          child: checkboxValue ? Icon(Icons.radio_button_checked, color: spacikoColor.ColorPrimary, size: 25,)
                              : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 25,),
                        ),
                        SizedBox(width: 10),

                        Expanded(
                          child: RichText(
                            text: TextSpan(
                                  children: [
                                    TextSpan(text: 'By signing up spaciko\'s ',style: TextStyle(color: spacikoColor.Colorlightblack,
                                        fontFamily: 'poppins_regular', fontSize: 14)),

                                    TextSpan(text: 'Terms and Conditions,',style: TextStyle(color: spacikoColor.ColorPrimary,
                                        fontFamily: 'poppins_regular', fontSize: 14),
                                        recognizer: TapGestureRecognizer()
                                             ..onTap =(){
                                              Navigator.push(context, MaterialPageRoute(
                                                         builder: (context) => TermsCond()
                                        ));
                                      }),

                                    TextSpan(text: ' Privacy Policy, Guest Refund, Consent disagree.',style: TextStyle(color: spacikoColor.Colorlightblack,
                                        fontFamily: 'poppins_regular', fontSize: 14)),
                                  ]
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  /*register button*/
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 52,
                    margin: EdgeInsets.only(left: 25, right: 25, top: 18),
                    child: RaisedButton(
                      color: spacikoColor.ColorPrimary,

                      child: Text("Register", style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite),),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),

                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FirstInroScreen()));
                        }
                      },
                    ),
                  ),


                  /*sign in with*/
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text("Sign In with", style: TextStyle(fontFamily: "poppins_regular", fontSize: 17 ,color: spacikoColor.Colorlightblack), ),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 15, right: 20),
                          child: Image(image: AssetImage('image/facebook.png'), height: 45, width: 45,),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Image(image: AssetImage('image/search.png'), height: 40, width: 40,),
                        ),
                      ],
                    ),
                  ),


                  /*not a member*/
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(fontSize: 16, fontFamily: "poppins_regular", color: spacikoColor.Colorlightblack),
                            children: <TextSpan>[
                              TextSpan(text: ' Log In', style: TextStyle(fontSize: 17, fontFamily: "poppins_medium",
                                  color: spacikoColor.ColorPrimary),

                                  recognizer: TapGestureRecognizer()
                                    ..onTap=(){
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (BuildContext context) => Login()));
                                    }
                              )
                            ]
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
