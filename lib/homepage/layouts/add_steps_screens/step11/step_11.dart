import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step11/ListofWeek.dart';
import 'package:spacikopooja/utils/setSizeBox.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ElevenStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  ElevenStep(this.currentpage, {this.onChangeFunction});

  @override
  _ElevenStepState createState() => _ElevenStepState();
}

class _ElevenStepState extends State<ElevenStep> {
  bool isSelected = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text('Set your space availability',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'poppins_semibold',
                    color: spacikoColor.Colorblack,
                    height: 1.2,
                  )),
              alignment: Alignment.center),

          setSizeBox(15),

          GestureDetector(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 18,
                  width: 18,
                  child: ClipOval(
                    child: Material(color: isSelected == true ? spacikoColor.ColorPrimary : spacikoColor.Colorwhite),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    'Use Sunday\'s opening hours for entire week', style: TextStyle(fontSize: 13, fontFamily: 'poppins_regular', color: spacikoColor.ColorBlackLightText),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),


          ListOfWeek(),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 30),
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              child: Text("Continue",
                  style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),

              onPressed: () {
                setState(() {
                  widget.onChangeFunction(widget.currentpage);
                });
              },
            ),
          ),

        ],
      ),
    );
  }
}
