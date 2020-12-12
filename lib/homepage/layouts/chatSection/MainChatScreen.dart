import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import 'ChatList.dart';

class MainchatScreen extends StatefulWidget {
  @override
  _MainchatScreenState createState() => _MainchatScreenState();
}

class _MainchatScreenState extends State<MainchatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        ChatList(),

        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: spacikoColor.Colorwhite
                ),

                child: Text(
                  'Translate this conversation to english powered by google',
                  style: TextStyle(color: spacikoColor.ColorBlackLightText, fontFamily:'poppins_regular', fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),


              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: spacikoColor.Colorwhite,
                        border: Border.all(color: spacikoColor.ColorBlackLightText, width: 0.5)
                    ),
                    alignment: Alignment.center,
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: 35),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Type Message...',
                        hintStyle: TextStyle(color: spacikoColor.ColorBlackLightText, fontSize: 16, fontFamily:'poppins_regular'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left:20, top: 15, bottom: 10, right: 10),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left:10, top: 15, bottom: 10, right: 10),
                    alignment: Alignment.centerRight,
                    child: Image(
                      alignment: Alignment.centerRight,
                      width: 25,
                      height: 25,
                      image: AssetImage('image/ic_send_msg.png'),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
