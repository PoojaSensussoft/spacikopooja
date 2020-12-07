import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_1.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class SecondStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage = 0;

  SecondStep(this.currentpage, {this.onChangeFunction});

  @override
  _SecondStepState createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
        onWillPop: () async {
          FirstStep(1,onChangeFunction: (val) => setState(()=>widget.currentpage = val));
          return true;
        },

    child: Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.onChangeFunction(widget.currentpage);
          });
        },
        child: Text('Continue 3',
            style: TextStyle(fontSize: 14, color: spacikoColor.Colorblack)),
      ),
    )
    );
  }
}
