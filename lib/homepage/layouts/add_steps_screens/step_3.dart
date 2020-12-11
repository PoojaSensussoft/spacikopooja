import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ThirdStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  ThirdStep(this.currentpage, {this.onChangeFunction});

  @override
  _ThirdStepState createState() => _ThirdStepState();
}

class _ThirdStepState extends State<ThirdStep> {
  int totalCount = 0;
  int countSpace = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.only(top: 10),
            child: Text('How many working guests will fit into your space?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'poppins_semibold',
                  color: spacikoColor.Colorblack,
                  height: 1.2,
                )),
            alignment: Alignment.center,
          ),

          SizedBox(height: 30),

          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(30),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: 47,
                    width: 50,
                    decoration: BoxDecoration(
                      color: spacikoColor.ColorPrimary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                    ),
                    child: Icon(Icons.remove, color: spacikoColor.Colorwhite),
                  ),
                  onTap: () {
                    setState(() {
                      if (totalCount > 0) {
                        totalCount = totalCount - 1;
                      }
                      print('Total_add::$totalCount');
                    });
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  height: 47,
                  width: 100,
                  color: spacikoColor.Colorwhite,
                  child: Text(
                    totalCount.toString(),
                    style: TextStyle(
                        color: spacikoColor.Colorblack,
                        fontSize: 16,
                        fontFamily: 'poppins_medium'),
                  ),
                ),

                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: 47,
                    width: 50,
                    decoration: BoxDecoration(
                      color: spacikoColor.ColorPrimary,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                    child: Icon(Icons.add, color: spacikoColor.Colorwhite),
                  ),
                  onTap: () {
                    setState(() {
                      totalCount = totalCount + 1;
                      print('Total_minus::$totalCount');
                    });
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.only(top: 30),
            child: Text('Do you allow visitors during the rent?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'poppins_semibold',
                  color: spacikoColor.Colorblack,
                  height: 1.2,
                )),
            alignment: Alignment.center,
          ),

          SizedBox(height: 25),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              setRadioYesNo(str: 'Yes', value: 1, onChanged: (val) => setState(() => countSpace = val)),

              setRadioYesNo(str: 'No', value: 0, onChanged: (val) => setState(() => countSpace = val)),
            ],
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 30),
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              child: Text("Continue",
                  style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),

              onPressed: () {
                countSpace == -1? Utility.showToast('Please Select field') :widget.onChangeFunction(widget.currentpage);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget setRadioYesNo({String str, int value, Function onChanged}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (str == 'Yes') {
            onChanged(1);
          } else {
            onChanged(0);
          }
        });
      },

      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 18),
            height: 23,
            width: 23,
            child: ClipOval(
              child: Material(
                color: value == countSpace
                    ? spacikoColor.ColorPrimary
                    : spacikoColor.Colorwhite,
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5),
            child: Text(
              str,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'poppins_regular',
                  color: spacikoColor.Colorblack),
            ),
          )
        ],
      ),
    );
  }
}
