import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/introscreen/FirstIntroScreen.dart';
import 'package:spacikopooja/utils/Validation.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import '../register/Register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
 TextEditingController password = new TextEditingController();


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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          /*for backgorud*/
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('image/login.png'), fit: BoxFit.fill),
          ),

          /*start form*/
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                /*logo*/
                Container(
                  margin: EdgeInsets.only(top: 100),
                  height: 135,
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
                        controller: email,
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
                      controller: password,
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

                /*forgot password*/
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text("Forgot Password?", style: TextStyle(fontFamily: "poppins_medium", fontSize: 16 ,color: spacikoColor.Colorblack), ),
                ),

                /*login button*/
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 52,
                  margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: RaisedButton(
                    color: spacikoColor.ColorPrimary,

                    child: Text("Log In", style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite),),

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
                        text: "Not a member?",
                        style: TextStyle(fontSize: 16, fontFamily: "poppins_regular", color: spacikoColor.Colorlightblack),
                        children: <TextSpan>[
                          TextSpan(text: ' Register', style: TextStyle(fontSize: 17, fontFamily: "poppins_medium",
                              color: spacikoColor.ColorPrimary),

                          recognizer: TapGestureRecognizer()
                            ..onTap=(){
                            print(email.text);
                            print(password.text);
                              Navigator.push(context, MaterialPageRoute(
                                  builder : (context) => Register(email.text, password.text)
                              ));
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
