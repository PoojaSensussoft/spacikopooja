import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class FirstStep extends StatefulWidget {
  var curStep;
  Function(int) onChangeFunction;

  FirstStep(this.curStep, {this.onChangeFunction});

  @override
  _FirstStepState createState() => _FirstStepState();
}


class _FirstStepState extends State<FirstStep> {
  List _cities = ["Select","Good", "Good1", "Good2"];
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
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
            SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              child: Text('Ready to replace your space in the Spotlight?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,
                    fontFamily: 'poppins_semibold',
                    color: spacikoColor.Colorblack),),
              alignment: Alignment.center,),
          ),

          SizedBox(height: 12,),

          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RichText(
              textAlign: TextAlign.center,

              text: TextSpan(text: 'With ',
                  style: TextStyle(color: spacikoColor.ColorBlackLightText,
                      fontFamily: 'poppins_regular', fontSize: 18, height: 1.3),

                  children: <TextSpan>[

                    TextSpan(text: 'spaciko ',
                  style: TextStyle(color: spacikoColor.ColorPrimary,
                      fontFamily: 'poppins_medium', fontSize: 18)),

                   TextSpan(text: 'each working space deserve a spacial care. Following these steps will allow you to highlight each working space as a separate listing ',
                      style: TextStyle(color: spacikoColor.ColorBlackLightText,
                          fontFamily: 'poppins_regular', fontSize: 18)),
                      ]
              ),
            ),
          ),


              SizedBox(height: 30,),

              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text('What type of space do you own?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17,
                      fontFamily: 'poppins_semibold',
                      color: spacikoColor.Colorblack)),
                alignment: Alignment.center,),

              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(30),

                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 45,

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: new Text('Pickup on every'),
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
                ),
              ),


              SizedBox(height: 80),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 52,
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),

                child: RaisedButton(
                  color: spacikoColor.ColorPrimary,

                  child: Text("Continue", style: TextStyle(fontSize: 18,
                      fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),

                  onPressed: () {
                    setState(() {
                      _currentCity=='Select'? Utility.showToast('Please Select type'): widget.onChangeFunction(widget.curStep);
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
