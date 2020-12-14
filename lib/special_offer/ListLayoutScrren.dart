import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/setSizeBox.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import 'PaymentDetail.dart';


class ListLayoutScreen extends StatefulWidget {
  @override
  _ListLayoutScreenState createState() => _ListLayoutScreenState();
}

class _ListLayoutScreenState extends State<ListLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        Container(
          height: 82,
          width: MediaQuery.of(context).size.width,

          child: Card(
            elevation: 2,
            color: spacikoColor.Colorwhite,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Expanded(
                  flex : 4,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: ExactAssetImage('image/splash.jpg'),
                          ),
                        ),

                        SizedBox(width: 5, height: 5),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Flexible(
                              child: Text('Abc Patel', style: TextStyle(color: spacikoColor.ColorBlackLightText,
                                  fontFamily: 'poppins_regular', fontSize: 15)),
                            ),

                            SizedBox(height: 2),
                            Flexible(
                              child: Text('Host', style: TextStyle(color: spacikoColor.ColorBlackLightText,
                                  fontFamily: 'poppins_semibold', fontSize: 15)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    margin: EdgeInsets.only(right: 5),
                    child: RaisedButton(
                      padding: EdgeInsets.all(5),
                      color: spacikoColor.Colorpink,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),

                      onPressed: () {
                        setState(() {

                        });
                      },

                      child: Flexible(
                        child: Text('Contact Host',
                            style: TextStyle(fontFamily: 'poppins_regular', fontSize: 12, color: spacikoColor.Colorwhite),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

        ),

        PaymentDetail(),

        setSizeBox(10),

        Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                height: 42,
                margin: EdgeInsets.only(left: 5,right: 8, bottom: 20),
                child: RaisedButton(
                  color: spacikoColor.Colorpink,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  onPressed: (){

                  },
                  child: Text(
                    'Accept' , style: TextStyle(color: spacikoColor.Colorwhite, fontSize: 16, fontFamily: 'poppins_semibold'),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child: Container(
                height: 42,
                margin: EdgeInsets.only(right: 5,left: 8,bottom: 20),
                child: RaisedButton(
                  color: spacikoColor.ColorPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  onPressed: (){

                  },
                  child: Text(
                    'Decline' , style: TextStyle(color: spacikoColor.Colorwhite, fontSize: 16, fontFamily: 'poppins_semibold')),
                ),
              ),
            )
          ],
        )

      ],
    );
  }
}
