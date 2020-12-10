import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/setSizeBox.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class TenthStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  TenthStep(this.currentpage, {this.onChangeFunction});

  @override
  _TenthStepState createState() => _TenthStepState();
}

class _TenthStepState extends State<TenthStep> {
  int isSelected = -1;
  TextEditingController dailyRate = new TextEditingController();
  TextEditingController monthlyRate = new TextEditingController();
  TextEditingController hourlyRate = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          setContainerText('Minimum stay Rules', 1),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child:
                Text('Choose one min rent rule you\'r most\ncomfortable with',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins_regular',
                      color: spacikoColor.ColorBlackLightText,
                    )),
            alignment: Alignment.center,
          ),

          setContainerText('Minimum Days', 2),

          setSizeBox(15),

            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isSelected = 0;
                    });
                  },

                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 20,
                    width: 20,
                    child: ClipOval(
                      child: Material(color: isSelected ==0? spacikoColor.ColorPrimary: spacikoColor.Colorwhite),
                    ),
                  ),
                ),

                Expanded(
                  child: setCardciew(),
                ),
              ],
            ),

          setSizeBox(10),

          setContainerText('Minimum hours', 2),

          setSizeBox(15),

          Row(
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    isSelected = 1;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 20,
                  width: 20,
                  child: ClipOval(
                    child: Material(color: isSelected ==1? spacikoColor.ColorPrimary: spacikoColor.Colorwhite),
                  ),
                ),
              ),

              Expanded(
                child: setCardciew(),
              ),

            ],
          ),

          setSizeBox(15),

          setContainerText('Set A price (USD)', 1),

          setSizeBox(10),

          setContainerText('Daily Rate', 2),

          setSizeBox(8),

          containerDailyRate(),

          setSizeBox(10),

          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    setContainerText('Monthly Rate', 2),

                    setSizeBox(8),
                    containerMonthlyRate(),
                  ],
                ),
              ),

              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    setContainerText('Hourly Rate', 2),

                    setSizeBox(8),
                    containerHourlyRate(),
                  ],
                ),
              ),
            ],
          ),


          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 20, right: 20, top: 25),
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              child: Text("Continue",
                  style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),

              onPressed: () {
                setState(() {
                  if(isSelected==-1){
                    Utility.showToast('Please select minimum time');

                 }else if(dailyRate.text.isEmpty){
                    Utility.showToast('Enter daily rate');

                  }else if(monthlyRate.text.isEmpty){
                    Utility.showToast('Enter monthly rate');

                  }else if(hourlyRate.text.isEmpty){
                    Utility.showToast('Enter hourly rate');

                  }else{
                    widget.onChangeFunction(widget.currentpage);
                  }

                });
              },
            ),
          ),

        ],
      ),
    );
  }


  Widget setContainerText(String str, int align) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Text(str,
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'poppins_semibold',
            color: spacikoColor.Colorblack,
            height: 1.2,
          )),
      alignment: align == 1 ? Alignment.center : Alignment.centerLeft,
    );
  }


  Widget setCardciew() {
    return Container(
      height: 45,
      margin: EdgeInsets.only(left: 10, right: 20),
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: spacikoColor.Colorwhite),

      child: TextFormField(
        cursorColor: spacikoColor.ColorPrimary,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
        ),
      ),
    );
  }


  Widget containerDailyRate() {
    return Container(
      height: 45,
      margin: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: spacikoColor.Colorwhite),

      child: TextFormField(
        controller: dailyRate,
        cursorColor: spacikoColor.ColorPrimary,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
        ),
      ),
    );
  }

  Widget containerMonthlyRate() {
    return Container(
      height: 45,
      margin: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: spacikoColor.Colorwhite),

      child: TextFormField(
        controller: monthlyRate,
        cursorColor: spacikoColor.ColorPrimary,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
        ),
      ),
    );
  }

  Widget containerHourlyRate() {
    return Container(
      height: 45,
      margin: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: spacikoColor.Colorwhite),

      child: TextFormField(
        controller: hourlyRate,
        cursorColor: spacikoColor.ColorPrimary,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
        ),
      ),
    );
  }
}
