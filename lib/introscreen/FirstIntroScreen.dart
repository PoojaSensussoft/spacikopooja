import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import 'SecondIntroScreen.dart';

void main() => runApp(FirstIntro());

class FirstIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FirstInroScreen(),
      ),
    );
  }
}


class FirstInroScreen extends StatefulWidget {
  @override
  _FirstInroScreeState createState() => _FirstInroScreeState();
}

class _FirstInroScreeState extends State<FirstInroScreen> {
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

        /*start scrolling*/
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,

          child: CustomScrollView(
            slivers: [

              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: <Widget>[

                          /*top image*/
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 1.9,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Image(
                              image: AssetImage('image/top_first_intro.png'),
                              fit: BoxFit.cover,
                            ),
                          ),

                          /*center text*/
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                                "Creating has never been easier".toUpperCase(),
                                style: TextStyle(fontFamily: "poppins_semibold",
                                    fontSize: 18,
                                    color: spacikoColor.Colorblack)
                            ),
                          ),

                          /*sec text*/
                          Container(
                            margin: EdgeInsets.only(top: 16, bottom: 30),
                            alignment: Alignment.center,

                            child: Text.rich(
                              TextSpan(children: <TextSpan>[
                                TextSpan(text: 'Spaciko,',
                                    style: TextStyle(fontSize: 16,
                                        fontFamily: "poppins_regular",
                                        color: spacikoColor.ColorPrimary)),

                                TextSpan(
                                    text: ' Setting new standards on leasing a\nprivate Working space!\n\nNow, you set the scene!',
                                    style: TextStyle(fontSize: 16,
                                        fontFamily: "poppins_regular",
                                        color: spacikoColor.Colorlightblack))
                              ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),

              ),


              SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/light_green.png'),
                        fit: BoxFit.fill),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[

                          Container(
                            width: 115,
                            child: GestureDetector(
                              child: Image(
                                image: AssetImage('image/red_round.png'),
                              ),
                            ),
                          ),

                          Container(
                            child: Text("Become\na host",
                              style: TextStyle(fontFamily: "poppins_medium",
                                  fontSize: 16, color: spacikoColor.Colorwhite),
                              textAlign: TextAlign.center,),
                          ),

                          Container(
                            width: 115,
                            child: GestureDetector(

                              onTap: (){
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (BuildContext context) => SecondIntroScreen()));
                              },
                            ),
                          ),
                        ],
                      ),


                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: 115,
                            child: Image(
                              image: AssetImage('image/light_red_round.png'),
                            ),
                          ),

                          Container(
                            child: Text("Work\nAnywhere",
                              style: TextStyle(fontFamily: "poppins_medium",
                                  fontSize: 16, color: spacikoColor.Colorwhite),
                              textAlign: TextAlign.center,),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
