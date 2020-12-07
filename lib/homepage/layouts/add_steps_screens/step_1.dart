import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class FirstStep extends StatefulWidget {
   Function(int) onChangeFunction;
   int currentPage;
   PageController pageController;

  FirstStep(int currentPage, PageController pageController, {onChangeFunction});

  @override
  _FirstStepState createState() => _FirstStepState();
}


Future<bool> _onBackPressed() {
  var currentPage;
  PageController pageController;

  print('ONBACKKK:::::$currentPage');
  return pageController.previousPage(duration: Duration(milliseconds: 30), curve: Curves.ease);
}


class _FirstStepState extends State<FirstStep> {
  _FirstStepState();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
          margin: EdgeInsets.all(100),
          child: RaisedButton(
            color: spacikoColor.ColorPrimary,
            onPressed: () {
              widget.onChangeFunction(1);
            },
            child: Text('Step 2',
                style: TextStyle(fontSize: 14, color: spacikoColor.Colorwhite)),
          ),
        ),
    );
  }

}