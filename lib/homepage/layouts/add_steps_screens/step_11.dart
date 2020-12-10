import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/model/SetHours.dart';
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
  List<String> _list = <String>[
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  int isSelected = -1;

  bool isSetHour = false;
  List<SetHours> selectedItemValue = List<SetHours>();
  List<SetHours> selctedHours = List<SetHours>();


  @override
  void initState() {
    super.initState();
  }


  List<DropdownMenuItem<String>> _listMenu() {
    List<String> list = ["Open", "Close"];
    return list.map((value) => DropdownMenuItem(value: value, child: Text(value),)).toList();
  }

  List<DropdownMenuItem<String>> _listHours() {
    List<String> list = ["All Over", "Set Hours"];
    return list.map((value) => DropdownMenuItem(value: value, child: Text(value),)).toList();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
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
                isSelected = 1;
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
                    child: Material(color: isSelected == 1 ? spacikoColor.ColorPrimary : spacikoColor.Colorwhite),
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

          _listOFDays(),
        ],
      ),
    );
  }

  Widget _listOFDays() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: _list.length,
      itemBuilder: (context, index) {

        for (int i = 0; i < _list.length; i++) {
          // selectedItemValue.add("Open");
          selectedItemValue.add(SetHours(title : "Open", selected: false));
          selctedHours.add(SetHours(title : "All Over", selected: false));
        }

        return Container(
          padding: EdgeInsets.only(right: 20,top: 5),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*text*/
                Expanded(
                  flex: 3,
                  child: Text(_list[index], style: TextStyle(fontFamily: 'poppins_medium',
                      fontSize: 18, color: spacikoColor.Colorblack), textAlign: TextAlign.center),
                ),

                /*ROW*/
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [

                      /*top row*/
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 35,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: spacikoColor.Colorwhite),

                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down, color: spacikoColor.ColorBlackLightText),
                                  style: TextStyle(color: spacikoColor.Colorlightblack,
                                      fontSize: 14, fontFamily: 'poppins_regular'),

                                  value: selectedItemValue[index].title.toString(),
                                  items: _listMenu(),

                                  onChanged: (String data) {
                                    selectedItemValue[index].title = data;
                                    selectedItemValue[index].title=='Close'? selectedItemValue[index].selected = true :selectedItemValue[index].selected = false;

                                    if(selectedItemValue[index].title=='Close' || selctedHours[index].title=='Set Hours'){
                                      selctedHours[index].title ="All Over";
                                      selctedHours[index].selected = !selctedHours[index].selected;
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),

                            ),
                          ),


                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 35,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: spacikoColor.Colorwhite),

                              child: DropdownButtonHideUnderline(
                                child: IgnorePointer(
                                  ignoring: selectedItemValue[index].selected,
                                  child: DropdownButton(
                                    isExpanded: true,
                                    icon: Icon(Icons.arrow_drop_down, color: spacikoColor.ColorBlackLightText),
                                    style: TextStyle(color: selectedItemValue[index].selected? Colors.grey : spacikoColor.Colorlightblack,
                                        fontSize: 14, fontFamily: 'poppins_regular'),

                                    value: selctedHours[index].title.toString(),
                                    items: _listHours(),

                                    onChanged: (String data) {
                                      selctedHours[index].title = data;
                                      selctedHours[index].title=='Set Hours'? selctedHours[index].selected = true :selctedHours[index].selected = false;

                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 10),
                      
                      /*Bottom row*/
                      Visibility(
                        visible: selctedHours[index].selected,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (){

                                },

                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: spacikoColor.ColorBlackLightText, width: 1),
                                      borderRadius: BorderRadius.circular(30),color: spacikoColor.Colorwhite),

                                  child: Text(
                                      'Open Time', style: TextStyle(color: spacikoColor.ColorBlackLightText,
                                      fontSize: 14, fontFamily: 'poppins_regular')
                                  ),
                                ),
                              ),
                            ),


                            Expanded(
                              child: GestureDetector(
                                onTap: (){

                                },

                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  margin: EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: spacikoColor.ColorBlackLightText, width: 1),
                                      borderRadius: BorderRadius.circular(30),color: spacikoColor.Colorwhite),

                                  child: Text(
                                      'Close Time', style: TextStyle(color: spacikoColor.ColorBlackLightText,
                                      fontSize: 14, fontFamily: 'poppins_regular')
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Divider(
                thickness: 0.5,
                color: spacikoColor.ColorBlackLightText,
              ),
            )
          ],
        ),
        );
      },
    );
  }
}
