import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacikopooja/publishList/CalenderView.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class CalenderNav extends StatefulWidget {


  @override
  _CalenderNavState createState() => _CalenderNavState();
}

class _CalenderNavState extends State<CalenderNav> {
  List _cities = ["Good", "Good1", "Good2"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;


  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: spacikoColor.ColorPrimary,

          child: Column(
            children: <Widget>[

          Container(
            height: 40,
            padding: EdgeInsets.only(left: 15, right: 10),
            margin: EdgeInsets.only(top: 25, bottom: 15),
            width: MediaQuery.of(context).size.width * 0.30,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: spacikoColor.Colorwhite
            ),


            /*drop down menu*/
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: spacikoColor.Colorblack,),
              style: TextStyle(color: spacikoColor.Colorblack, fontSize: 14, fontFamily: 'poppins_regular'),
              value: _currentCity,
              items: _dropDownMenuItems,

              onChanged: (String data) {
                setState(() {
                  _currentCity = data;
                });
              },
            ),
            ),
          ),


              /*Calender view*/
              Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: spacikoColor.Colorwhite
                ),

                child: CalendarView(),

              ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
