import 'package:flutter/material.dart';
import 'package:spacikopooja/chirag/CheckItem.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

void main() => runApp(UserProfile());

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                    child: Container(
                      child: Column(
                        children: <Widget>[

                          /*top green bottom rounded*/
                          Stack(
                            children: <Widget>[

                              Container(height: 120,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
                                    color: spacikoColor.ColorPrimary),
                              ),

                              Container(
                                padding: const EdgeInsets.only(right: 15, top: 20, bottom: 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Image(
                                      image: AssetImage('image/ic_notification_white.png'),
                                      height: 25,
                                      width: 25),
                                ),
                              ),

                              Positioned(
                                top: 8,
                                right: 17,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                  alignment: Alignment.center,
                                  child: Text('1', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 12 ,color:spacikoColor.Colorwhite),),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 60),
                                alignment: Alignment.center,
                                child: Image(image: AssetImage('image/ic_defult.png'), height: 110, width: 110),
                              ),
                            ],
                          ),


                          /*user name*/
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Text('Abc Sensussoft', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 16, color: spacikoColor.Colorblack),),
                          ),


                          /*profile button*/
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width*0.5,
                            child: RaisedButton(
                              color: spacikoColor.ColorPrimary,
                              child: Text("My Profile",
                                style: TextStyle(fontSize: 16, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite),),

                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),

                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
                                      margin: EdgeInsets.only(left: 20,top: 30),
                                      child: Image(image: AssetImage('image/ic_settings.png'), height: 25,width: 25),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 13,top: 30),
                                      child: Text('Settings', style: TextStyle(fontSize: 16, fontFamily: 'poppins_regular',color: spacikoColor.Colorlightblack),),
                                    ),

                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(right: 20,top: 30),
                                  alignment: Alignment.centerRight,
                                  child: Image(image: AssetImage('image/ic_rigthtback_green.png'), height: 20,width: 20,),
                                ),
                              ],
                            ) ,

                            onTap: (){

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
                                      margin: EdgeInsets.only(left: 20,top: 25),
                                      child: Image(image: AssetImage('image/ic_help.png'), height: 25,width: 25),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 13,top: 25),
                                      child: Text('Help and Support', style: TextStyle(fontSize: 16, fontFamily: 'poppins_regular',color: spacikoColor.Colorlightblack),),
                                    ),

                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(right: 20,top: 25),
                                  alignment: Alignment.centerRight,
                                  child: Image(image: AssetImage('image/ic_rigthtback_green.png'), height: 20,width: 20,),
                                ),
                              ],
                            ) ,

                            onTap: (){

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
                                      margin: EdgeInsets.only(left: 20,top: 25),
                                      child: Image(image: AssetImage('image/ic_listing.png'), height: 25,width: 25),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 13,top: 25),
                                      child: Text('My Listings', style: TextStyle(fontSize: 16, fontFamily: 'poppins_regular',color: spacikoColor.Colorlightblack),),
                                    ),

                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(right: 20,top: 25),
                                  alignment: Alignment.centerRight,
                                  child: Image(image: AssetImage('image/ic_rigthtback_green.png'), height: 20,width: 20,),
                                ),
                              ],
                            ) ,

                            onTap: (){

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
                                      margin: EdgeInsets.only(left: 20,top: 25),
                                      child: Image(image: AssetImage('image/ic_dispute.png'), height: 25,width: 25),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 13,top: 25),
                                      child: Text('My Reservations', style: TextStyle(fontSize: 16, fontFamily: 'poppins_regular',color: spacikoColor.Colorlightblack),),
                                    ),

                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(right: 20,top: 25),
                                  alignment: Alignment.centerRight,
                                  child: Image(image: AssetImage('image/ic_rigthtback_green.png'), height: 20,width: 20,),
                                ),
                              ],
                            ) ,

                            onTap: (){

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
                                      margin: EdgeInsets.only(left: 20,top: 25),
                                      child: Image(image: AssetImage('image/ic_dispute.png'), height: 25,width: 25),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 13,top: 25),
                                      child: Text('Dispute Center', style: TextStyle(fontSize: 16, fontFamily: 'poppins_regular',color: spacikoColor.Colorlightblack),),
                                    ),

                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(right: 20,top: 25),
                                  alignment: Alignment.centerRight,
                                  child: Image(image: AssetImage('image/ic_rigthtback_green.png'), height: 20,width: 20,),
                                ),
                              ],
                            ) ,

                            onTap: (){

                            },
                          ),


                          /*Contact us*/
                          GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 20,top: 25),
                                      child: Image(image: AssetImage('image/ic_contect.png'), height: 25,width: 25),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 13,top: 25),
                                      child: Text('Contact Us', style: TextStyle(fontSize: 16, fontFamily: 'poppins_regular',color: spacikoColor.Colorlightblack),),
                                    ),

                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(right: 20,top: 25),
                                  alignment: Alignment.centerRight,
                                  child: Image(image: AssetImage('image/ic_rigthtback_green.png'), height: 20,width: 20,),
                                ),
                              ],
                            ) ,

                            onTap: (){

                            },
                          ),

                        ],
                      ),
                    ),
              )
        ),
      ),
    );
  }
}
