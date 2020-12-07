import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class FifthStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  FifthStep(this.currentpage,{this.onChangeFunction});

  @override
  _FifthStepState createState() => _FifthStepState();
}

class _FifthStepState extends State<FifthStep> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.onChangeFunction(widget.currentpage);
          });
        },
        child: Text('Continue 6',
            style: TextStyle(fontSize: 14, color: spacikoColor.Colorblack)),
      ),

    );
  }
}
