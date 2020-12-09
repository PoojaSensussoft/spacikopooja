import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/model/ModelClass.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class TwelveStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  TwelveStep(this.currentpage,{this.onChangeFunction});

  @override
  _TwelveStepState createState() => _TwelveStepState();
}

class _TwelveStepState extends State<TwelveStep> {
  List _cities = ["Select Policy", "In case of cancellation 24 hours prior to arrival, the guest will get full refund (booking fees excluded)"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[1].value;
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
    return SingleChildScrollView(
      child: Column(
        children: [
          setContainerText('Set your cancellation policy'),

          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 12),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),

              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                height: 80,

                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: new Text('Select Policy'),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: spacikoColor.Colorblack,),
                    style: TextStyle(color: spacikoColor.ColorBlackLightText, fontSize: 14, fontFamily: 'poppins_regular', height: 1.2),
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
            ),
          ),

          SizedBox(height: 12),
          setContainerText('Security deposit (Optional)'),

          Container(
            child: Row(

              children: [
                Expanded(
                  flex: 8,
                  child: Container(alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: spacikoColor.Colorwhite,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                    ),


                    child: TextFormField(
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

                  ),
                ),

                /*set drop down*/
                dropDown(),

              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget setContainerText(String str){
    return  Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Text(str,
          style: TextStyle(fontSize: 17, fontFamily: 'poppins_semibold', color: spacikoColor.Colorblack, height: 1.2,)),
      alignment: Alignment.centerLeft,
    );
  }


  Widget dropDown(){
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 20),
        height: 50,
        decoration: BoxDecoration(
          color: spacikoColor.ColorPrimary,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
        ),


        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: spacikoColor.ColorPrimary,
            iconSize: 0,
            isExpanded: false,
            icon: Icon(Icons.arrow_drop_down, color: spacikoColor.Colorblack,),
            style: TextStyle(color: spacikoColor.Colorwhite, fontSize: 16, fontFamily: 'poppins_regular'),
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
    );
  }
}
