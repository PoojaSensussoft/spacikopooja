import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class SecondStep extends StatefulWidget {
  Function(int) onChangeFunction;
  int currentPage;
  PageController pageController;

  SecondStep(int currentPage, PageController pageController, {onChangeFunction});


  @override
  _SecondStepState createState() => _SecondStepState();
}


class _SecondStepState extends State<SecondStep> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      child: Container(
        margin: EdgeInsets.all(100),
        child: RaisedButton(
          color: spacikoColor.ColorPrimary,
          onPressed: () {
            widget.onChangeFunction(2);
          },
          child: Text('Step 3',
              style: TextStyle(fontSize: 14, color: spacikoColor.Colorwhite)),
        ),
      ),
    );
  }

}
