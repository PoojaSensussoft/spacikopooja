import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/add_steps_screens/step_1.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/Validation.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class SecondStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage = 0;

  SecondStep(this.currentpage, {this.onChangeFunction});

  @override
  _SecondStepState createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  int countSpace = -1;
  int countSharePrivate = -1;
  int countExperience = -1;
  final _formKey = GlobalKey<FormState>();

  List _list = ['SF', 'M2'];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[1].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _list) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              setContainerText('Is your space fully furnished?'),

              SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  setRadioYesNo(str: 'Yes', value: 1, onChanged: (val) => setState(() => countSpace = val)),
                  setRadioYesNo(str: 'No', value: 0, onChanged: (val) => setState(() => countSpace = val)),
                ],
              ),

              SizedBox(height: 20),

              setContainerText('How many rooms do you offer?'),

              /*set cardview*/
              setCardciew(),

              SizedBox(height: 25),

              setContainerText('Are you Working Stations/desks\nshared or private?'),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  setRadioSharedPrivate(str: 'Shared', value: 1, onChanged: (val) => setState(() => countSharePrivate = val)),
                  setRadioSharedPrivate(str: 'Private', value: 0, onChanged: (val) => setState(() => countSharePrivate = val)),
                ],
              ),

              SizedBox(height: 20),

              setContainerText('Have you ever hosted your venue\nwith a website like a spaciko before?'),

              SizedBox(height: 20),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  setExperienced(str: 'No, I\'m new to all this!', value: 1, onChanged: (val) => setState(() => countExperience = val)),

                  SizedBox(height: 20),

                  setExperienced(str: 'Yes, I\'m experienced with space hosting', value: 0, onChanged: (val) => setState(() => countExperience = val)),
                ],
              ),

              SizedBox(height: 25),

              setContainerText('How big is your space?'),

              SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        color: spacikoColor.Colorwhite,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                      ),


                      child: TextFormField(
                        cursorColor: spacikoColor.ColorPrimary,
                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
                        ),
                      ),

                    ),
                  ),

                  /*set drop down*/
                  dropDown(),

                ],
              ),

              SizedBox(height: 25),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 52,
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),

                child: RaisedButton(
                  color: spacikoColor.ColorPrimary,

                  child: Text("Continue", style: TextStyle(fontSize: 18,
                      fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite),),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),

                  onPressed: () {
                    countSpace== -1 || countSharePrivate== -1 || countExperience== -1 ||!_formKey.currentState.validate()
                        ? Utility.showToast('Please fill all the field')
                        : widget.onChangeFunction(widget.currentpage);
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }


  Widget setRadioYesNo({String str, int value, Function onChanged}){
    return GestureDetector(
      onTap: (){
        setState(() {
          if(str=='Yes'){
            onChanged(1);
          }else{
            onChanged(0);
          }
        });
      },

      child: Row(
        children: [
         Container(
           margin: EdgeInsets.only(left: 18), height: 23, width: 23,

           child: ClipOval(
             child: Material(
               color: value==countSpace? spacikoColor.ColorPrimary: spacikoColor.Colorwhite,
             ),
           ),
         ),

         Container(
           alignment: Alignment.center,
           padding: EdgeInsets.only(left: 5),
           child: Text(str, textAlign: TextAlign.center,
             style: TextStyle(fontSize: 16, fontFamily: 'poppins_regular', color: spacikoColor.Colorblack),
           ),
         )
       ],
      ),
    );
  }


  Widget setRadioSharedPrivate({String str, int value, Function onChanged}){
    return GestureDetector(
      onTap: (){
        setState(() {
          if(str=='Shared'){
            onChanged(1);
          }else{
            onChanged(0);
          }
        });
      },

      child: Row(
          children: [
            Container(margin: EdgeInsets.only(left: 18), height: 23, width: 23,

              child: ClipOval(
                child: Material(
                  color: value==countSharePrivate? spacikoColor.ColorPrimary: spacikoColor.Colorwhite,
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 5),
              child: Text(
                str,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins_regular',
                    color: spacikoColor.Colorblack
                ),
              ),
            )
          ],
        ),

    );
  }


  Widget setExperienced({String str, int value, Function onChanged}){
    return GestureDetector(
      onTap: (){
        setState(() {
          if(str=='No, I\'m new to all this!'){
            onChanged(1);
          }else{
            onChanged(0);
          }
        });
      },

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(margin: EdgeInsets.only(left: 18), height: 23, width: 23,

            child: ClipOval(
              child: Material(
                color: value==countExperience? spacikoColor.ColorPrimary: spacikoColor.Colorwhite,
              ),
            ),
          ),

          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 8),
              child: Text(
                str,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins_regular',
                    color: spacikoColor.Colorblack
                ),
              ),
            ),
          )
        ],
      ),

    );
  }

  Widget setCardciew(){
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(30),

        child: Container(
          height: 50,

            child: TextFormField(
              cursorColor: spacikoColor.ColorPrimary,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
              ),

              validator: (text){
                if(Validation.isNameEmpty(text)){
                  return 'Enter the value';
                }else{
                  return null;
                }
              },
            ),
        ),
      ),
    );
  }


  Widget setContainerText(String str){
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
          str,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontFamily: 'poppins_regular', color: spacikoColor.Colorblack, height: 1.2,),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.center,
    );
  }


  Widget dropDown(){
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 20),
        height: 50,
        decoration: BoxDecoration(
          color: spacikoColor.ColorPrimary,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
        ),


        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: spacikoColor.ColorPrimary,
            iconSize: 0,
            isExpanded: false,
            icon: Icon(Icons.arrow_drop_down, color: spacikoColor.Colorblack,),
            style: TextStyle(color: spacikoColor.Colorwhite, fontSize: 16, fontFamily: 'poppins_regular'),
            value: _currentCity,
            items: _dropDownMenuItems,

            onChanged: (String data) {
              setState(() {
                _currentCity = data;
              });
            },
          ),
        ),
      ),
    );
  }
}
