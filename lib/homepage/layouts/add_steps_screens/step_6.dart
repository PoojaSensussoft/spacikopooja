import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/model/ModelClass.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class SixStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  SixStep(this.currentpage,{this.onChangeFunction});

  @override
  _SixStepState createState() => _SixStepState();
}

class _SixStepState extends State<SixStep> {
  List<ModelClass> _list = <ModelClass>[
    ModelClass(title: 'Delivery Access'),
    ModelClass(title: 'Garage Door'),
    ModelClass(title: 'Elevator'),
    ModelClass(title: 'Parking Near By'),
    ModelClass(title: 'Stairs'),
  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text('How can guests access your place?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontFamily: 'poppins_semibold', color: spacikoColor.Colorblack, height: 1.2,)),
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

                          Container(height: 23, width: 23,
                            child: ClipOval(
                              child: Material(color: _list[index].selected ? spacikoColor.ColorPrimary : spacikoColor.Colorwhite,
                              ),
                            ),
                          ),

                          SizedBox(width: 10),
                          Text(_list[index].title,
                            style: TextStyle(fontSize: 17, fontFamily: 'poppins_regular', color: spacikoColor.Colorlightblack),
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
                setState(() {
                  var bool = false;
                  for(var i=0;i<_list.length;i++) {
                    if(_list[i].selected) {
                      bool=true;
                      break;
                    }
                  }

                  !bool? Utility.showToast('Please Select field') : widget.onChangeFunction(widget.currentpage);
                });
              },
            ),
          ),


        ],
      ),

    );
  }
}
