import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class FirstStep extends StatefulWidget {
  var curStep;
  Function(int) onChangeFunction;

  FirstStep(this.curStep, {this.onChangeFunction});

  @override
  _FirstStepState createState() => _FirstStepState();
}


Future<bool> _onWillPop() async {
  return (await showDialog(
    builder: (context) => new AlertDialog(
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit an App'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('No'),
        ),
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: new Text('Yes'),
        ),
      ],
    ),
  )) ?? false;
}


class _FirstStepState extends State<FirstStep> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            setState(() {
              widget.onChangeFunction(widget.curStep);
            });
          },
          child: Text('Continue 2',
              style: TextStyle(fontSize: 14, color: spacikoColor.Colorblack)),
        ),
      ),
    );
  }
}
