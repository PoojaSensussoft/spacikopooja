import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import 'CalenderView.dart';

class PublishList extends StatefulWidget {
  @override
  _PublishListState createState() => _PublishListState();
}

class _PublishListState extends State<PublishList> {
  List<String> _list = <String>[
    'Select Time',
    '3 months',
    '6 months',
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentTime;


  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentTime = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String time in _list) {
      items.add(new DropdownMenuItem(
          value: time,
          child: new Text(time)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text("Show work travelers when\nthey can book",
                  style: TextStyle(fontSize: 17, fontFamily: 'poppins_medium', color: spacikoColor.ColorBlackLightText,
                    height: 1.2,), textAlign: TextAlign.center),
            ),


            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(left: 25, top: 20),
                  height: 35,
                  width: MediaQuery.of(context).size.width*0.6,

                  decoration: BoxDecoration(
                      color: spacikoColor.Colorwhite,
                      borderRadius: BorderRadius.circular(30)
                  ),

                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: spacikoColor.Colorwhite,
                      icon: Icon(Icons.arrow_drop_down, color: spacikoColor.Colorblack,),
                      style: TextStyle(color: spacikoColor.ColorPrimary, fontSize: 14, fontFamily: 'poppins_regular'),
                      value: _currentTime,
                      items: _dropDownMenuItems,

                      onChanged: (String data) {
                        setState(() {
                          _currentTime = data;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            CalendarView(),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 52,
              margin: EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 20),
              child: RaisedButton(
                color: spacikoColor.Colorpink,
                child: Text("publish my listing!".toUpperCase(),
                    style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),

                onPressed: () {
                  setState(() {
                    // widget.onChangeFunction(widget.currentpage);
                  });
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

}
