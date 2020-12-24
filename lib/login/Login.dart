import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacikopooja/Database/database_helper.dart';
import 'package:spacikopooja/forgot_password/Forgot_Password.dart';
import 'package:spacikopooja/introscreen/FirstIntroScreen.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/Validation.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'package:sqflite/sqflite.dart';
import '../register/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';



class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login_1(),
    );
  }
}

class Login_1 extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  return _LoginState()._showNotification(message);
}

class _LoginState extends State<Login_1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  SharedPreferences prefs;

  Map<String, dynamic> _userData;
  AccessToken _accessToken;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final dbHelper = DatabaseHelper.instance;
  Database db;
  String isCheck = "false";
  String login_with = "";

  List<Message> messagesList;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  DatabaseReference itemRef;
  List<Item> items = List();
  Item item;

  Future _showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel desc',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
    new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'new message arived',
      'i want ${message['data']['title']} for ${message['data']['price']}',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }


  @override
  void initState() {
    super.initState();
    make_table_in_firebase();

    queryUsers().then((query){
      query.once().then((snapshot){
        print('get_all_data::::$snapshot');
      });
    });

    dbInit();
     // main();

    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);

    _firebaseMessaging.configure(
      onBackgroundMessage: myBackgroundHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('new message arived'),
                content: Text(
                    'i want ${message['notification']['title']} for ${message['notification']['body']}'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );

    _getToken();

  }

  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("DeviceToken:::$token");
      prefs.setString(Utility.DEVICE_TOKEN, token);
      item.device_token = token;
    });
  }

  Future selectNotification(String payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> dbInit() async {
    prefs = await SharedPreferences.getInstance();
    db = await DatabaseHelper.instance.database;
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
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));
                  },

                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text("Forgot Password?", style: TextStyle(fontFamily: "poppins_medium", fontSize: 16 ,color: spacikoColor.Colorblack), ),
                  ),
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

                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        List<Map>result = await db.rawQuery('SELECT * FROM my_table WHERE email=?',[email.text]);

                        if(result.length!=0){
                          result.forEach((row) {
                            if(row['loginwith']=="email" && row['email'] == email.text && row['password']==password.text) {
                              Utility.showToast("Login Successfully");

                              String name = row['fname']+" "+row['lname'];
                              print('nnmmaaee::::$name');

                              // prefs.setString(Utility.USER_EMAIL, email.text);
                              // prefs.setString(Utility.USER_NAME, name);

                              item.email = email.text;

                              itemRef.push().set(item.toJson());
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (BuildContext context) => FirstInroScreen()));

                            }else{
                              Utility.showToast("User is not Exist");
                              print('else_1::::${result.length}');
                            }
                          });

                        }else{
                          Utility.showToast("User is not Exist");
                          print('else_2::::${result.length}');
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

                      /*facebook*/
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

                      /*google login*/
                      GestureDetector(
                        onTap: () async{
                          login_with = "gmail";
                          signInWithGoogle();
                        },

                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Image(image: AssetImage('image/search.png'), height: 40, width: 40),
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

  void handleSubmit() {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
    }
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

    prefs.setString(Utility.USER_EMAIL, user.email);
    prefs.setString(Utility.USER_NAME, user.displayName);

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
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => FirstInroScreen()));
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

        String name = userData1['first_name']+" "+userData1['last_name'];

        prefs.setString(Utility.USER_EMAIL, userData1['email']);
        prefs.setString(Utility.USER_NAME, name);

        Future.delayed(Duration(milliseconds: 50), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => FirstInroScreen()));
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


  void make_table_in_firebase() {
    item = Item("", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('Users');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }

  static Future<Query> queryUsers() async{
    return FirebaseDatabase.instance.reference().child("Users");
  }

}

class Item {
  String key;
  String email;
  String device_token;

  Item(this.email, this.device_token);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        email = snapshot.value["email"],
        device_token = snapshot.value["device_token"];

  toJson() {
    return {
      "email": email,
      "device_token": device_token,
    };
  }
}



class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}