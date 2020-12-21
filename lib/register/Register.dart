import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacikopooja/Database/database_helper.dart';
import 'package:spacikopooja/introscreen/FirstIntroScreen.dart';
import 'package:spacikopooja/login/Login.dart';
import 'package:spacikopooja/terms_cond/TermsAndcond.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/Validation.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'package:sqflite/sqflite.dart';


class Register extends StatefulWidget {
  String email;
  String password;

  Register(String email, String password) {
    this.email = email;
    this.password = password;
  }

  @override
  _RegisterState createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool checkboxValue = false;

  TextEditingController controllerfname = TextEditingController();
  TextEditingController controllerlname = TextEditingController();
  TextEditingController controlleremail = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  String isCheck = "false";
  String login_with = "";
  final dbHelper = DatabaseHelper.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);
  String google_user_name;
  String google_email;
  String google_id;

  SharedPreferences prefs;

  Map<String, dynamic> _userData;
  AccessToken _accessToken;

  Database db;


  @override
  void initState() {
    _query();
    dbInit();
    super.initState();
  }

  Future<void> dbInit() async {
     db = await DatabaseHelper.instance.database;
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
                              controller: controllerfname,
                              cursorColor: spacikoColor.ColorPrimary,
                              keyboardType: TextInputType.text,

                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20),
                                labelText: "First Name",
                                labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(color: spacikoColor.ColorPrimary)
                                ),
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
                              controller: controllerlname,
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
                        initialValue: widget.email,
                        cursorColor: spacikoColor.ColorPrimary,
                        keyboardType: TextInputType.emailAddress,

                        onChanged: (text){
                          controlleremail.text = text;
                        },

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
                        onChanged: (text){
                          controllerpassword.text = text;
                        },

                        initialValue: widget.password,
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
                              checkboxValue? isCheck = "true": isCheck = "false";
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

                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          login_with = "email";

                          List<Map> result1 = await db.rawQuery('SELECT * FROM my_table WHERE email=?',[controlleremail.text]);

                          if(result1.length!=0){
                            result1.forEach((row) {
                              if(row['loginwith']=="email") {
                                Utility.showToast("Email id already exist!");

                              }else{
                                _update("", controllerfname.text, controllerlname.text,
                                    controlleremail.text, controllerpassword.text, isCheck, login_with, row['id']);
                              }
                            });

                          }else{
                            _insert("", controllerfname.text, controllerlname.text, controlleremail.text,
                                controllerpassword.text, isCheck, login_with);
                          }
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
                        GestureDetector(
                          onTap: (){
                            login_with = "facebook";
                            _loginFB();
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 15, right: 20),
                            child: Image(image: AssetImage('image/facebook.png'), height: 45, width: 45,),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            login_with = "gmail";
                            signInWithGoogle();
                          },

                          // onTap: _handleSignIn,

                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Image(image: AssetImage('image/search.png'), height: 40, width: 40,),
                          ),
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


  void _insert(String columnID, String f_name, String l_name, String email, String password, String ischeck, String login_with) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnAppId : columnID,
      DatabaseHelper.columnFName : f_name,
      DatabaseHelper.columnLName  : l_name,
      DatabaseHelper.columnEmail : email,
      DatabaseHelper.columnPassword : password,
      DatabaseHelper.columnIscheck : ischeck,
      DatabaseHelper.columnLoginwith : login_with,
    };

    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    Utility.showToast("Register Successfully!");
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
    Utility.showToast("User Updated Successfully!");
  }

  void _query() async{
      final allRow = await dbHelper.queryAllRows();
      print('all_rows::::$allRow');

      allRow.forEach((element) {
        return null;
      });
  }


  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final idToken = googleSignInAuthentication.idToken;

    Map<String, dynamic> idMap = parseJwt(idToken);

    final String firstName = idMap["given_name"];
    final String lastName = idMap["family_name"];

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken);

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    if(user!=null){
      List<Map> result1 = await db.rawQuery('SELECT * FROM my_table WHERE email=?',[user.email]);

      if(result1.length!=0){
        result1.forEach((row) {
          _update(user.uid, firstName, lastName, user.email, "", "", login_with, row['id']);
        });

      }else{
        _insert(user.uid, firstName, lastName, user.email, "", "", login_with);
      }

      Future.delayed(Duration(milliseconds: 50), () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {return FirstInroScreen();}));
      });
    }
    return 'signInWithGoogle succeeded: $user';
  }


  static Map<String, dynamic> parseJwt(String token) {
    if (token == null) return null;
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));

    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }


  Future<void> _loginFB() async {
    try {
      _accessToken = await FacebookAuth.instance.login();
      _printCredentials(_accessToken);

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      _checkIfIsLogged();

    } on FacebookAuthException catch (e) {
      print('CATCH:::::${e.message}');

      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          Utility.showToast("You have a previous login operation in progress");
          break;

        case FacebookAuthErrorCode.CANCELLED:
          Utility.showToast("login cancelled");
          break;

        case FacebookAuthErrorCode.FAILED:
          Utility.showToast("login failed");
          break;
      }

    } catch (e, s) {
      print(e);
      print(s);
    }
  }


  Future<void> _checkIfIsLogged() async {
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;

    if (accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;

      final userData1 = await FacebookAuth.instance.getUserData(fields: "first_name,last_name,gender,email,birthday,friends,link,name,picture");

      if(userData!=null){
        List<Map> result1 = await db.rawQuery('SELECT * FROM my_table WHERE email=?',[userData1['email']]);

        if(result1.length!=0){
          result1.forEach((row) {
            _update(userData1['id'], userData1['first_name'], userData1['last_name'], userData1['email'],
                "", "", login_with, row['id']);
          });
        }else{
          _insert(userData1['id'], userData1['first_name'], userData1['last_name'], userData1['email'],
              "", "", login_with);
        }

        Future.delayed(Duration(milliseconds: 50), () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {return FirstInroScreen();}));
        });
      }

      setState(() {
        _userData = userData;
      });
    }
  }


  void _printCredentials(AccessToken accessToken) {
    print(prettyPrint(_accessToken.toJson()));
  }


  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }
}
