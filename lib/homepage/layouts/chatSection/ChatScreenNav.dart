import 'package:flutter/material.dart';
import 'package:spacikopooja/special_offer/SpecialOffer.dart';
import 'package:spacikopooja/utils/setSizeBox.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'ChatList.dart';
import 'MainChatScreen.dart';


class ChatScreenNav extends StatefulWidget {
  @override
  _ChatScreenNavState createState() => _ChatScreenNavState();
}


class _ChatScreenNavState extends State<ChatScreenNav> {
  int isSpecialOffer = 1;
  bool isOfferVisible = true;
  bool isText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: spacikoColor.ColorPrimary,
        child: Column(
          children: [
            setSizeBox(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp,
                      color: spacikoColor.Colorwhite),
                  iconSize: 25,
                  onPressed: () {
                    setState(() {
                      if(isSpecialOffer>1){
                        /*list of chat visible set bool*/
                        isSpecialOffer = isSpecialOffer-1;
                        isOfferVisible = true;
                        isText = false;
                      }
                    });
                  },
                ),

                Visibility(
                  visible: isText,
                  child: Padding(
                    padding: EdgeInsets.only(right: 50),
                    child: Text(
                      'Special Offer',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: spacikoColor.Colorwhite, fontFamily: 'poppins_medium'),
                    ),
                  ),
                ),

                Visibility(
                  visible: isOfferVisible,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          /*navigate to special offer*/
                          isSpecialOffer = 2;
                          isOfferVisible = false;
                          isText = true;
                        });
                      },

                      color: spacikoColor.Colorpink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text('Special Offer',
                        style: TextStyle(fontFamily: 'poppins_semibold', fontSize: 15, color: spacikoColor.Colorwhite),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: spacikoColor.Colorlihgt_green),

                child: isSpecialOffer==1? MainchatScreen() : SpecialOffer(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
