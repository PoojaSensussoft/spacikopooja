import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ForthStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  ForthStep(this.currentpage,{this.onChangeFunction});

  @override
  _ForthStepState createState() => _ForthStepState();
}

class _ForthStepState extends State<ForthStep> {
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
        child: Text('Continue 5',
            style: TextStyle(fontSize: 14, color: spacikoColor.Colorblack)),
      ),
    );
  }
}
