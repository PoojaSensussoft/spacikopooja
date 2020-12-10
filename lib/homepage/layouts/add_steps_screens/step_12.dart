import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/setSizeBox.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class TwelveStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  TwelveStep(this.currentpage,{this.onChangeFunction});

  @override
  _TwelveStepState createState() => _TwelveStepState();
}

class _TwelveStepState extends State<TwelveStep> {
  List _list = ["Select Policy", "In case of cancellation 24 hours prior to arrival, the guest will get full refund (booking fees excluded)"];
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
    for (String city in _list) {
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

          setSizeBox(12),

          setContainerText('Security deposit (Optional)'),

         securityDeposit(),

          setSizeBox(12),
          setContainerText('Extended rental policy-3 months or more'),

          bulletText('Once a reservation is confirmed the guest will provide the host 2 security cheques that will back the booking'),

          bulletText('Management fees,city taxes & utility bills are excluded from the booking and will be paid directly pay by guest.'),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 30),

            child: RaisedButton(
              color: spacikoColor.ColorPrimary,

              child: Text("Continue", style: TextStyle(fontSize: 18,
                  fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite),),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              ),

              onPressed: () {
                setState(() {
                  _currentCity ==_dropDownMenuItems[0].value ? Utility.showToast("Please Select policy"):widget.onChangeFunction(widget.currentpage);
                });
              },
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

  Widget securityDeposit(){
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 20),

      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 2,

        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                color: spacikoColor.ColorPrimary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
              ),

              child: Text('ILS', style: TextStyle(color: spacikoColor.Colorwhite,
                  fontFamily: 'poppins_medium', fontSize: 18)),
            ),


            Expanded(
              flex: 8,
              child: Container(alignment: Alignment.centerLeft,
                height: 50,

                decoration: BoxDecoration(
                  color: spacikoColor.Colorwhite,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
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



          ],
        ),
      ),
    );
  }

  Widget bulletText(String setText){
    return Container(
      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      child : Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            child: Text('*  ',
                style: TextStyle(fontSize: 14, fontFamily: 'poppins_medium', color: spacikoColor.ColorBlackLightText,
                  height: 1.2,), textAlign: TextAlign.start),
          ),

          Expanded(
            child: Text(setText,
                style: TextStyle(fontSize: 14, fontFamily: 'poppins_medium', color: spacikoColor.ColorBlackLightText, height: 1.2, letterSpacing: 0.2)),
          ),
        ],
      ),
    );

  }
}
