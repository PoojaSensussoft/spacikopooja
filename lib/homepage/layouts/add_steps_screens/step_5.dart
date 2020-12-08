import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class FifthStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  FifthStep(this.currentpage,{this.onChangeFunction});

  @override
  _FifthStepState createState() => _FifthStepState();
}

class _FifthStepState extends State<FifthStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('Please provide the full physical address\nof your venued',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'poppins_semibold',
                  color: spacikoColor.Colorblack,
                  height: 1.2,
                )),
            alignment: Alignment.center,
          ),

          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text('My Listing Address',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'poppins_semibold',
                  color: spacikoColor.Colorblack,
                  height: 1.2,
                )),
            alignment: Alignment.centerLeft,
          ),

          Material(
            elevation: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: spacikoColor.Colorwhite),

              child: Row(children: [
                TextFormField(
                  cursorColor: spacikoColor.ColorPrimary,
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,

                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
                  ),
                ),
              ],),
            ),
          ),
        ],
      ),
    );
  }
}
