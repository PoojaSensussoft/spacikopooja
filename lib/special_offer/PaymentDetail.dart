import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/setSizeBox.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class PaymentDetail extends StatefulWidget {
  @override
  _PaymentDetailState createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.only(top: 2),
      width: MediaQuery.of(context).size.width,

      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage('image/ic_user_green_24.png'),height: 22, width: 22),
                  SizedBox(width: 10),
                  Text('4 guests', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 15, color: spacikoColor.Colorblack))
                ],
              ),
            ),

            setSizeBox(15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,

              children: [
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('image/ic_calender_green_24.png'),height: 22, width: 22),
                        SizedBox(width: 10),
                        Flexible(child: Text('Jan, 23 2020\n09 am', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 15, color: spacikoColor.Colorblack)))
                      ],
                    ),
                  ),
                ),

                Image(image: AssetImage('image/ic_arrow_right_side.png'),height: 22, width: 22),

                Flexible(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 10),

                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(child: Text('Jan, 23 2020\n09 am', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 15, color: spacikoColor.Colorblack))),
                        SizedBox(width: 10),
                        Image(image: AssetImage('image/ic_calender_green_24.png'),height: 22, width: 22),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Divider(
                thickness: 0.2,
                color: spacikoColor.Colorblack,
              ),
            ),

            Container(
              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text('Payment Breakdown', style: TextStyle(fontFamily: 'poppins_semibold', fontSize: 15, color: spacikoColor.Colorblack),
                  textAlign: TextAlign.start),
            ),

            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('9 Hours', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack)),

                  Text('\$16', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack))
                ],
              ),
            ),

            setSizeBox(10),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Security Deposit', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack)),

                  Text('-', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack))
                ],
              ),
            ),

            setSizeBox(10),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service Fee', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack)),

                  Text('\$2', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack))
                ],
              ),
            ),

            setSizeBox(10),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('VAT', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack)),

                  Text('\$3', style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack))
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Divider(
                thickness: 0.2,
                color: spacikoColor.Colorblack,
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Original Payment', style: TextStyle(fontFamily: 'poppins_semibold', fontSize: 14, color: spacikoColor.Colorblack)),

                  Text('\$21', style: TextStyle(fontFamily: 'poppins_semibold', fontSize: 14, color: spacikoColor.Colorblack))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
