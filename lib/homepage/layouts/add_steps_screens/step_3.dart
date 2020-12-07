import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ThirdStep extends StatefulWidget {
  @override
  _ThirdStepState createState() => _ThirdStepState();
}

class _ThirdStepState extends State<ThirdStep> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        color: spacikoColor.ColorPrimary,
        onPressed: () {},
        child: Text('Step 4',
            style: TextStyle(fontSize: 14, color: spacikoColor.Colorwhite)),
      ),
    );
  }
}
