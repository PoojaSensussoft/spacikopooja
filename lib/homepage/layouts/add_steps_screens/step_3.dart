import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ThirdStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  ThirdStep(this.currentpage,{this.onChangeFunction});

  @override
  _ThirdStepState createState() => _ThirdStepState();
}

class _ThirdStepState extends State<ThirdStep> {
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
        child: Text('Continue 4',
            style: TextStyle(fontSize: 14, color: spacikoColor.Colorblack)),
      ),
    );
  }
}
