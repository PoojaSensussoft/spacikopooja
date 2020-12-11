import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_10.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step11/step_11.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_12.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_2.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_3.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_4.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_5.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_6.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_7.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_9.dart';
import 'package:spacikopooja/model/CustomStep.dart';
import 'package:spacikopooja/publishList/PublishList.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import 'add_steps_screens/step_1.dart';
import 'add_steps_screens/step_8.dart';


class NewAddNav extends StatefulWidget {
  @override
  _AddNavState createState() => _AddNavState();
}

class _AddNavState extends State<NewAddNav> {
  List<String> _list;
  var activeColor = spacikoColor.ColorPrimary;
  var inActiveColor = spacikoColor.ColorOpacity;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,

        body: WillPopScope(
          onWillPop: _onBackPressed,
          child: Container(
            color: spacikoColor.ColorPrimary,

            child: Expanded(

              /*white rouned bg*/
              child: Container(
                margin: EdgeInsets.only(top: 90),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: spacikoColor.Colorlihgt_green,),


                child: currentIndex != 13 ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _ListWidegts(),
                      ),
                    ),

                    Expanded(
                      child: _setLayout(),
                    )
                  ],

                ) : PublishList(),
              ),
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> _ListWidegts() {
    var list = <Widget>[];

    print('curr:::$currentIndex');

    if (currentIndex < 7) {
      _list = ['1', '2', '3', '4', '5', '6'];
    } else {
      _list = ['7', '8', '9', '10', '11', '12'];
    }

    _list.asMap().forEach((i, value) {
      var circleColor =
      (int.parse(_list[i]) == currentIndex) ? activeColor : inActiveColor;

      list.add(
        Container(width: 32.0, height: 32.0,
          child: Center(
            child: Text(value, style: TextStyle(color: Colors.white),),),

          decoration: new BoxDecoration(color: circleColor,
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
          ),
        ),
      );

      if (i != _list.length - 1) {
        list.add(Expanded(
            child: Container(
              height: 2,
              color: spacikoColor.ColorPrimary,
            )
        )
        );
      }
    });
    return list;
  }


  Widget _setLayout() {
    if (currentIndex == 1) {
      return FirstStep(2, onChangeFunction: (val) => setState(() => currentIndex = val));

    } else if (currentIndex == 2) {
      return SecondStep(
          3, onChangeFunction: (val) => setState(() => currentIndex = val));
    } else if (currentIndex == 3) {
      return ThirdStep(
          4, onChangeFunction: (val) => setState(() => currentIndex = val));
    } else if (currentIndex == 4) {
      return ForthStep(
          5, onChangeFunction: (val) => setState(() => currentIndex = val));
    } else if (currentIndex == 5) {
      return FifthStep(
          6, onChangeFunction: (val) => setState(() => currentIndex = val));
    }
    else if (currentIndex == 6) {
      return SixStep(
          7, onChangeFunction: (val) => setState(() => currentIndex = val));
    }
    else if (currentIndex == 7) {
      return SevenStep(
          8, onChangeFunction: (val) => setState(() => currentIndex = val));
    } else if (currentIndex == 8) {
      return EightStep(
          9, onChangeFunction: (val) => setState(() => currentIndex = val));
    }
    else if (currentIndex == 9) {
      return NineStep(
          10, onChangeFunction: (val) => setState(() => currentIndex = val));
    }
    else if (currentIndex == 10) {
      return TenthStep(
          11, onChangeFunction: (val) => setState(() => currentIndex = val));
    }
    else if (currentIndex == 11) {
      return ElevenStep(
          12, onChangeFunction: (val) => setState(() => currentIndex = val));
    }
    else if (currentIndex == 12) {
      return TwelveStep(
          13, onChangeFunction: (val) => setState(() => currentIndex = val));
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),

              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  print('onBack:::$currentIndex');
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<T> pushPage<T>(BuildContext context, Widget page) {
    return Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) => page));
  }

}



