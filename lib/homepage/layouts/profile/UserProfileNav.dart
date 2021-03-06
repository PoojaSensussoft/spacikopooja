import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacikopooja/MyListing/MyListing.dart';
import 'package:spacikopooja/MyListing/PoojaVerifyOtp.dart';
import 'package:spacikopooja/VideoPlayer.dart';
import 'package:spacikopooja/allConcepts/AllConcepts.dart';
import 'package:spacikopooja/booking/BookingSceen.dart';
import 'package:spacikopooja/contactus/ContactUs.dart';
import 'package:spacikopooja/help_and_support/HelpandSupport.dart';
import 'package:spacikopooja/homepage/layouts/profile/MyProfile.dart';
import 'package:spacikopooja/login/Login.dart';
import 'package:spacikopooja/pagination/ListPagination.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: UserProfileNav(),
      ),
    );
  }
}

class UserProfileNav extends StatefulWidget {
  @override
  _UserProfileNavState createState() => _UserProfileNavState();
}

class _UserProfileNavState extends State<UserProfileNav> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String userName;

  _getToken() {
    _firebaseMessaging.getToken().then((value) {
      print('Device Token: $value');
    });
  }

  List<Message> messagesList;

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['Message'];
    print("Title: $title, body: $body, message: ${mMessage??'Hello'}");

    setState(() {
      Message msg = Message(title, body, mMessage??'Hello');
      messagesList.add(msg);
    });
  }


  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            userName = prefValue.getString(Utility.USER_NAME) ?? '';
          })
        });

    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Container(
            child: Column(
              children: <Widget>[

                /*top green bottom rounded*/
                Stack(
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35)),
                          color: spacikoColor.ColorPrimary),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15, top: 20, bottom: 20),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Image(
                            image:
                                AssetImage('image/ic_notification_white.png'),
                            height: 25,
                            width: 25),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 17,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        alignment: Alignment.center,
                        child: Text(
                          '1',
                          style: TextStyle(
                              fontFamily: 'poppins_regular',
                              fontSize: 12,
                              color: spacikoColor.Colorwhite),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60),
                      alignment: Alignment.center,
                      child: Image(
                          image: AssetImage('image/ic_defult.png'),
                          height: 110,
                          width: 110),
                    ),
                  ],
                ),

                /*user name*/
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text(
                    userName ?? '0',
                    style: TextStyle(
                        fontFamily: 'poppins_regular',
                        fontSize: 16,
                        color: spacikoColor.Colorblack),
                  ),
                ),

                /*profile button*/
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: RaisedButton(
                    color: spacikoColor.ColorPrimary,
                    child: Text(
                      "My Profile",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "poppins_semibold",
                          color: spacikoColor.Colorwhite),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
                    },
                  ),
                ),

                /*setting*/
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 30),
                            child: Image(
                                image: AssetImage('image/ic_settings.png'),
                                height: 25,
                                width: 25),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 30),
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 30),
                        alignment: Alignment.centerRight,
                        child: Image(
                          image: AssetImage('image/ic_rigthtback_green.png'),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),

                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => BookingScreen()));
                  },
                ),


                /* Logout */
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            child: Image(
                                image: AssetImage('image/logout.png'),
                                height: 25,
                                width: 25,
                                color: spacikoColor.ColorPrimary),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 25),
                            child: Text(
                              'All Concepts',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 20, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                            image: AssetImage('image/ic_rigthtback_green.png'),
                            height: 20,
                            width: 20),
                      ),
                    ],
                  ),

                  onTap: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => AllConcepts()));
                  },
                ),


                /*help and support*/
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            child: Image(
                                image: AssetImage('image/ic_help.png'),
                                height: 25,
                                width: 25),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 25),
                            child: Text(
                              'Help and Support',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                          image: AssetImage('image/ic_rigthtback_green.png'),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),

                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => HelpandSupport()));
                  },
                ),

                /*my listing*/
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            child: Image(
                                image: AssetImage('image/ic_listing.png'),
                                height: 25,
                                width: 25),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 25),
                            child: Text(
                              'StartActivityFor Result',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                          image: AssetImage('image/ic_rigthtback_green.png'),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),

                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => MyListing()));
                  },
                ),

                /*my reservation*/
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            child: Image(
                                image: AssetImage('image/ic_dispute.png'),
                                height: 25,
                                width: 25),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 13, top: 25),
                            child: Text(
                              'Video Player',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 20, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                          image: AssetImage('image/ic_rigthtback_green.png'),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),

                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => MainVideoPlayer()));
                  },
                ),

                /*Dispuet center*/
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            child: Image(
                                image: AssetImage('image/ic_dispute.png'),
                                height: 25,
                                width: 25),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 25),
                            child: Text(
                              'Enter OTP',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                          image: AssetImage('image/ic_rigthtback_green.png'),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),

                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => PoojaVerifyOTP()));
                  },
                ),

                /* Contact us */
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            child: Image(
                                image: AssetImage('image/ic_contect.png'),
                                height: 25,
                                width: 25),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 25),
                            child: Text(
                              'Contact Us',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                          image: AssetImage('image/ic_rigthtback_green.png'),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),

                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => ContactUs()));
                  },
                ),

                /* pagination */
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            child: Image(
                                image: AssetImage('image/logout.png'),
                                height: 25,
                                width: 25,
                                color: spacikoColor.ColorPrimary),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 25),
                            child: Text(
                              'Pagination list',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                            image: AssetImage('image/ic_rigthtback_green.png'),
                            height: 20,
                            width: 20),
                      ),
                    ],
                  ),

                  onTap: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => ListPagination()));
                        // MaterialPageRoute(builder: (BuildContext context) => DemoPagination()));
                  },
                ),





                /* Logout */
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            child: Image(
                                image: AssetImage('image/logout.png'),
                                height: 25,
                                width: 25,
                                color: spacikoColor.ColorPrimary),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 25),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'poppins_regular',
                                  color: spacikoColor.Colorlightblack),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 25),
                        alignment: Alignment.centerRight,
                        child: Image(
                            image: AssetImage('image/ic_rigthtback_green.png'),
                            height: 20,
                            width: 20),
                      ),
                    ],
                  ),

                  onTap: () async {
                    show_dialog(context);
                  },
                ),

                SizedBox(height: 20)
              ],
            ),
          ),
        ));

  }

  void show_dialog(BuildContext context) {
    Widget cancelbutton = FlatButton(
      child: Text('No'),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    Widget okaybutton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Utility.showToast("Logout successfully!");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();

        Navigator.of(context,rootNavigator:true).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Login()));
      },
    );

    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Are you sure you want to logout ?",
        style: TextStyle(
            fontFamily: 'poppins_regular',
            fontSize: 14,
            color: spacikoColor.Colorblack),
      ),
      actions: [cancelbutton, okaybutton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
