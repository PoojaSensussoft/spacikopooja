import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/profile/UserProfile.dart';
import 'package:spacikopooja/utils/setSizeBox.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}


class _MyProfileState extends State<MyProfile> {

  @override
  Widget build(BuildContext context) {
    return Container(
        color: spacikoColor.ColorPrimary,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            setSizeBox(30),

            IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.arrow_back_ios_sharp,
                  color: spacikoColor.Colorwhite),
              iconSize: 25,
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),

            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: spacikoColor.Colorlihgt_green),

                child: UserProfile(),
              ),
            )
          ],
        ),
    );
  }




}
