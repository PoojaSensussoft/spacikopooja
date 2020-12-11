import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/model/SetHours.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ListOfWeek extends StatefulWidget {

  @override
  _ListOfWeekState createState() => _ListOfWeekState();
}

class _ListOfWeekState extends State<ListOfWeek> {
  List<String> _list = <String>[
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  bool isSetHour = false;
  List<SetHours> selectedItemValue = List<SetHours>();
  List<SetHours> selctedHours = List<SetHours>();

  List<String> listOpenTime = List<String>();
  List<String> listCloseTime = List<String>();

  DateTime pickedDate;
  TimeOfDay time;

  TimeOfDay selectedTime =TimeOfDay.now();


  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  List<DropdownMenuItem<String>> _listMenu() {
    List<String> list = ["Open", "Close"];
    return list.map((value) => DropdownMenuItem(value: value, child: Text(value),)).toList();
  }

  List<DropdownMenuItem<String>> _listHours() {
    List<String> list = ["All Over", "Set Hours"];
    return list.map((value) => DropdownMenuItem(value: value, child: Text(value),)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: _list.length,
      itemBuilder: (context, index) {

        for (int i = 0; i < _list.length; i++) {
          selectedItemValue.add(SetHours(title : "Open", selected: false));
          selctedHours.add(SetHours(title : "All Over", selected: false));
          listOpenTime.add('Open Time');
          listCloseTime.add('Close Time');
        }

        return Container(
          padding: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*text*/
                  Expanded(
                    flex: 3,
                    child: Text(_list[index], style: TextStyle(fontFamily: 'poppins_medium',
                        fontSize: 18, color: spacikoColor.Colorblack), textAlign: TextAlign.center),
                  ),

                  /*ROW*/
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [

                        /*top row*/
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                  height: 35,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 8),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: spacikoColor.Colorwhite),

                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down, color: spacikoColor.ColorBlackLightText),
                                      style: TextStyle(color: spacikoColor.Colorlightblack,
                                          fontSize: 14, fontFamily: 'poppins_regular'),

                                      value: selectedItemValue[index].title.toString(),
                                      items: _listMenu(),

                                      onChanged: (String data) {
                                        selectedItemValue[index].title = data;
                                        selectedItemValue[index].title=='Close'? selectedItemValue[index].selected = true :selectedItemValue[index].selected = false;

                                        if(selectedItemValue[index].title=='Close' && selctedHours[index].title=='Set Hours'){
                                          selctedHours[index].title ="All Over";
                                          selctedHours[index].selected = !selctedHours[index].selected;
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),

                                ),
                              ),
                            ),

                            SizedBox(width: 5),

                            Expanded(
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  height: 35,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: spacikoColor.Colorwhite),

                                  child: DropdownButtonHideUnderline(
                                    child: IgnorePointer(
                                      ignoring: selectedItemValue[index].selected,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        icon: Icon(Icons.arrow_drop_down, color: spacikoColor.ColorBlackLightText),
                                        style: TextStyle(color: selectedItemValue[index].selected? Colors.grey : spacikoColor.Colorlightblack,
                                            fontSize: 14, fontFamily: 'poppins_regular'),

                                        value: selctedHours[index].title.toString(),
                                        items: _listHours(),

                                        onChanged: (String data) {
                                          selctedHours[index].title = data;
                                          selctedHours[index].title=='Set Hours'? selctedHours[index].selected = true :selctedHours[index].selected = false;

                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 5),

                        /*Bottom row*/
                        Visibility(
                          visible: selctedHours[index].selected,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    _pickTime(context, 'open_time', index);
                                  },

                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      // margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: spacikoColor.ColorBlackLightText, width: 1),
                                          borderRadius: BorderRadius.circular(30),color: spacikoColor.Colorwhite),

                                      child: Text(listOpenTime[index], style: TextStyle(color: spacikoColor.ColorBlackLightText,
                                          fontSize: 14, fontFamily: 'poppins_regular')
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 5),

                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    _pickTime(context, 'close_time', index);
                                  },

                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      // margin: EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: spacikoColor.ColorBlackLightText, width: 1),
                                          borderRadius: BorderRadius.circular(30),color: spacikoColor.Colorwhite),

                                      child: Text(listCloseTime[index], style: TextStyle(color: spacikoColor.ColorBlackLightText,
                                          fontSize: 14, fontFamily: 'poppins_regular')
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Divider(
                  thickness: 0.5,
                  color: spacikoColor.ColorBlackLightText,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<Null> _pickTime(BuildContext context, String time, int index) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context, initialTime: selectedTime);

    if (picked_s != null && picked_s != selectedTime)

      setState(() {
        selectedTime = picked_s;
        time=='open_time' ? listOpenTime[index] = picked_s.format(context) : listCloseTime[index] = picked_s.format(context);
      });
  }

}
