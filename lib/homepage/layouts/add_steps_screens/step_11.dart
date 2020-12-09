import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/model/ModelClass.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ElevenStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  ElevenStep(this.currentpage,{this.onChangeFunction});

  @override
  _ElevenStepState createState() => _ElevenStepState();
}

class _ElevenStepState extends State<ElevenStep> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          GestureDetector(
            onTap: (){
              setState(() {
                widget.onChangeFunction(widget.currentpage);
              });
            },

            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text('Step number 11',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontFamily: 'poppins_semibold', color: spacikoColor.Colorblack, height: 1.2,)),
              alignment: Alignment.center,
            ),
          ),

        ],
      ),

    );
  }
}
