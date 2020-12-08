import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_2.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_3.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_4.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_5.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_6.dart';
import 'package:spacikopooja/model/CustomStep.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

import 'add_steps_screens/step_1.dart';


class NewAddNav extends StatefulWidget {
  @override
  _AddNavState createState() => _AddNavState();
}

class _AddNavState extends State<NewAddNav> {
  List<String> _list = ['1', '2', '3', '4', '5', '6'];
  var activeColor = spacikoColor.ColorPrimary;
  var inActiveColor = spacikoColor.ColorOpacity;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
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

              child: Column(
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
              ),
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> _ListWidegts() {
    var list = <Widget>[];
    _list.asMap().forEach((i, value) {
      var circleColor =
      (i == currentIndex) ? activeColor : inActiveColor;

      list.add(
        Container(
          width: 32.0,
          height: 32.0,
          child: Center(
            child: Text(value, style: TextStyle(color: Colors.white),),),
          decoration: new BoxDecoration(
            color: circleColor,
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
    if(currentIndex ==0){
      return FirstStep(1,onChangeFunction: (val) => setState(()=>currentIndex = val));

    } else if(currentIndex==1){
      return SecondStep(2,onChangeFunction: (val) => setState(()=>currentIndex = val));

    }else if(currentIndex==2){
      return ThirdStep(3,onChangeFunction: (val) => setState(()=>currentIndex = val));

    }else if(currentIndex==3){
      return ForthStep(4,onChangeFunction: (val) => setState(()=>currentIndex = val));

    }else if(currentIndex==4){
      return FifthStep(5,onChangeFunction: (val) => setState(()=>currentIndex = val));
    }
    else if(currentIndex==5){
      return SixStep(6,onChangeFunction: (val) => setState(()=>currentIndex = val));
    }
  }
}




