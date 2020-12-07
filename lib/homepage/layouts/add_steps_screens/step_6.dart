import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class SixStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  SixStep(this.currentpage,{this.onChangeFunction});

  @override
  _SixStepState createState() => _SixStepState();
}

class _SixStepState extends State<SixStep> {
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
        child: Text('Continue 7',
            style: TextStyle(fontSize: 14, color: spacikoColor.Colorblack)),
      ),
    );
  }
}
