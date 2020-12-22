import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/Home.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class SecondIntroScreen extends StatefulWidget {
  @override
  _SecondIntroScreenState createState() => _SecondIntroScreenState();
}

class _SecondIntroScreenState extends State<SecondIntroScreen> {
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

          /*for backgorud*/
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('image/sec_intro.png'), fit: BoxFit.cover),
          ),

          // child: Column(
          //   children: <Widget>[
          //     /*top text*/
          //     Container(
          //       margin: EdgeInsets.only(top: 90),
          //       child: Text(
          //         'Host the work space\nrevolution!'.toUpperCase(),
          //         style: TextStyle(fontSize: 21, fontFamily: 'poppins_semibold',color: spacikoColor.Colorwhite),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //
          //
          //     /*center text*/
          //     Container(
          //       margin: EdgeInsets.only(top: 20),
          //       child: Text(
          //         'Got Free Space?',
          //         style: TextStyle(fontSize: 18, fontFamily: 'poppins_medium',color: spacikoColor.Colorwhite),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //
          //
          //     /*third text*/
          //     Container(
          //       width: MediaQuery.of(context).size.width,
          //       alignment: Alignment.center,
          //       margin: EdgeInsets.only(top: 25),
          //       child: Text(
          //         'Share Your Space With Thousands\nOf Startups and Freelancers\nInstantly ready to book it!',
          //         style: TextStyle(fontSize: 18, fontFamily: 'poppins_medium',color: spacikoColor.Colorwhite),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //
          //
          //     /*become host button*/
          //     Container(
          //       width: MediaQuery.of(context).size.width,
          //       height: 52,
          //       margin: EdgeInsets.only(left: 25, right: 25, top: 10),
          //
          //       child: RaisedButton(
          //         color: spacikoColor.ColorPrimary,
          //         child: Text("become a host".toUpperCase(),
          //           style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite),),
          //
          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          //
          //         onPressed: () {
          //             Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          //         },
          //
          //       ),
          //     ),
          //   ],
          // ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Column(
                children: <Widget>[
                  /*top text*/
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        child: Text(
                          'Host the work space\nrevolution!'.toUpperCase(),
                          style: TextStyle(fontSize: 20, fontFamily: 'poppins_semibold',color: spacikoColor.Colorwhite,height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ),


                      /*center text*/
                      Container(
                        margin: EdgeInsets.only(top: 13),
                        child: Text(
                          'Got Free Space?',
                          style: TextStyle(fontSize: 17, fontFamily: 'poppins_medium',color: spacikoColor.Colorwhite),
                          textAlign: TextAlign.center,
                        ),
                      ),


                      /*third text*/
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          'Share Your Space With Thousands\nOf Startups and Freelancers\nInstantly ready to book it!',
                          style: TextStyle(fontSize: 17, fontFamily: 'poppins_medium',color: spacikoColor.Colorwhite, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ),

                ],
              ),

              /*become host button*/
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 52,
                    margin: EdgeInsets.only(left: 25, right: 25, top: 10,bottom: 60),

                    child: RaisedButton(
                      color: spacikoColor.Colorpink,
                      child: Text("become a host".toUpperCase(),
                        style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite),),

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),

                      onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (BuildContext context) => Home()));
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
