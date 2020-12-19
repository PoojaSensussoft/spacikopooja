import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacikopooja/introscreen/FirstIntroScreen.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/Validation.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import '../register/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
 TextEditingController password = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  SharedPreferences prefs;

  Map<String, dynamic> _userData;
  AccessToken _accessToken;

  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }


  @override
  void initState() {
    super.initState();
    main();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }


  Future<void> _login() async {
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
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
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
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      final userData = await FacebookAuth.instance.getUserData();

      print('get_all_data::::::$userData');

      _accessToken = accessToken;

      final userData1 = await FacebookAuth.instance.getUserData(fields: "gender,email,birthday,friends,link,name,picture");
      print('get_all_data:11:::::$userData1');

      if(userData!=null){
        print('get_image:::${userData1['picture']}');
        print('get_image1:::${userData1['picture']}');
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {return FirstInroScreen();}));
      }

      setState(() {
        _userData = userData;
      });
    }
  }

  void _printCredentials(AccessToken accessToken) {
    print(prettyPrint(_accessToken.toJson()));
  }


  Future<void> main() async {
    prefs = await SharedPreferences.getInstance();
    var email = prefs.getString(Utility.USER_EMAIL);
    print('get_mail::::$email');
    runApp(MaterialApp(debugShowCheckedModeBanner: false,
        home: email == null ? Login() : FirstInroScreen()));
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

                      /*facebook*/
                      GestureDetector(
                        // onTap: (){
                        //   initiateFacebookLogin();
                        // },

                        onTap: (){
                          _login();
                          },

                        child: Container(
                          margin: EdgeInsets.only(top: 15, right: 20),
                          child: Image(image: AssetImage('image/facebook.png'), height: 45, width: 45,),
                        ),
                      ),

                      /*google login*/
                      GestureDetector(
                        onTap: () async{
                          signInWithGoogle();
                        },

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


  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('diaplay_name:::${user.displayName}');
    print('diaplay_email:::${user.email}');
    print('diaplay_number:::${user.phoneNumber}');

    prefs.setString(Utility.USER_EMAIL, user.email);
    prefs.setString(Utility.USER_NAME, user.displayName);

    if(user!=null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {return FirstInroScreen();}));
    }
    return 'signInWithGoogle succeeded: $user';
  }
}
