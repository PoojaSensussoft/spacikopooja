import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/model/ModelClass.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class NineStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  NineStep(this.currentpage,{this.onChangeFunction});

  @override
  _NineStepState createState() => _NineStepState();
}

class _NineStepState extends State<NineStep> {
TextEditingController listname = new TextEditingController();
TextEditingController summary = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          setContainerText('Tell travelers more about your space', 1),

          SizedBox(height: 15),

          Container(
            padding: EdgeInsets.only(left: 10, right: 10),

            child: RichText(
              textAlign: TextAlign.center,

              text: TextSpan(text: 'Every ',
                  style: TextStyle(color: spacikoColor.ColorBlackLightText,
                      fontFamily: 'poppins_regular', fontSize: 16, height: 1.3),

                  children: <TextSpan>[
                    TextSpan(text: 'Spaciko ',
                        style: TextStyle(color: spacikoColor.ColorPrimary,
                            fontFamily: 'poppins_medium', fontSize: 16)),

                    TextSpan(text: 'is Unique. By highlighting your venue\'s most special features, you can stand out in your area and earn more bookings!',
                        style: TextStyle(color: spacikoColor.ColorBlackLightText,
                            fontFamily: 'poppins_regular', fontSize: 16)),
                  ]
              ),
            ),
          ),


          SizedBox(height: 20),
          setContainerText('Listing Name', 2),

          setCardciew(),

          SizedBox(height: 20),
          setContainerText('Summary', 2),

          setCardciewSummary(),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 25, right: 25, top: 50),
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              child: Text("Continue",
                  style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),

              onPressed: () {
                setState(() {

                  if (listname.text.isEmpty || summary.text.isEmpty) {
                    Utility.showToast('Please Select field');

                  } else {
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

  Widget setContainerText(String str, int align){
    return  Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Text(str,
          style: TextStyle(fontSize: 16, fontFamily: 'poppins_semibold', color: spacikoColor.Colorblack, height: 1.2,)),
      alignment: align==1? Alignment.center :Alignment.centerLeft,
    );
  }


  Widget setCardciew(){
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18 ,top: 10),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(30),

        child: Container(
          height: 50,

          child: TextFormField(
            controller: listname,
            cursorColor: spacikoColor.ColorPrimary,
            keyboardType: TextInputType.name,

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
    );
  }


  Widget setCardciewSummary(){
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18 ,top: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),

        child: Container(
          height: 120,

          child: TextFormField(
            controller: summary,
            maxLines: null,
            cursorColor: spacikoColor.ColorPrimary,
            keyboardType: TextInputType.name,

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
    );
  }
}
