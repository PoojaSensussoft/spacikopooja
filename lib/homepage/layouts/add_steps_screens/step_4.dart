import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ForthStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  ForthStep(this.currentpage,{this.onChangeFunction});

  @override
  _ForthStepState createState() => _ForthStepState();
}

class _ForthStepState extends State<ForthStep> {
  List<ModelClass> _list = <ModelClass>[
    ModelClass(title: 'Body Temperature Thermometer'),
    ModelClass(title: 'Hand Sanitizer'),
    ModelClass(title: 'Air Condition'),
    ModelClass(title: 'ADSL Internet'),
    ModelClass(title: 'Wireless Internet'),
  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('Please Select all of the amenities that\ncan be found in your space. tick as few\nor more as are relevant',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'poppins_semibold',
                  color: spacikoColor.Colorblack,
                  height: 1.2,
                )),
            alignment: Alignment.center,
          ),

          SizedBox(height: 20),

          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: _list.length,
              itemBuilder: (context, index) {

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _list[index].selected = !_list[index].selected;
                    });
                  },

                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          // _list[index].selected ? Icon(Icons.check_circle, color: spacikoColor.ColorPrimary, size: 25,)
                          //     : Icon(Icons.circle, color: Colors.grey[300], size: 25,),

                          Container(
                            height: 23,
                            width: 23,
                            child: ClipOval(
                              child: Material(
                                color: _list[index].selected
                                    ? spacikoColor.ColorPrimary
                                    : spacikoColor.Colorwhite,
                              ),
                            ),
                          ),

                          SizedBox(width: 10),
                          Text(_list[index].title,
                            style: TextStyle(fontSize: 17, fontFamily: 'poppins_regular',
                                color: spacikoColor.Colorlightblack),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),


          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 25, right: 25, top: 50),
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              child: Text("Continue",
                  style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),

              onPressed: () {
                // if (_list.map((e) => e.selected)) {
                //   Utility.showToast('Please Select feild');
                // } else {
                  widget.onChangeFunction(widget.currentpage);
                // }
              },
            ),
          ),

        ],
      ),

    );
  }
}


/*Few ticks*/
class ModelClass {
  String title;
  bool selected = false;

  ModelClass({this.title});
}

