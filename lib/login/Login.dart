import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacikopooja/homepage/Home.dart';
import 'package:spacikopooja/introscreen/FirstIntroScreen.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/Validation.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import '../register/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


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


  @override
  void initState() {
    super.initState();
    main();
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
                      Container(
                        margin: EdgeInsets.only(top: 15, right: 20),
                        child: Image(image: AssetImage('image/facebook.png'), height: 45, width: 45,),
                      ),

                      GestureDetector(
                        onTap: () async{
                          signInWithGoogle().whenComplete(() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return FirstInroScreen();
                                },
                              ),
                            );
                          });
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
    return 'signInWithGoogle succeeded: $user';
  }
}
