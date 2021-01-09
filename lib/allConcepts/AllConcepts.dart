import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacikopooja/qrcode_scanner/QrCode_Scanner.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class AllConcepts extends StatefulWidget {

  @override
  _AllConceptsState createState() => _AllConceptsState();
}

class _AllConceptsState extends State<AllConcepts> {
  DateTime selectedDate = DateTime.now();
  String date = DateFormat("dd MMM yyyy, EEE").format(DateTime.now());

  DateTime _cupSelectedDate = DateTime.now();
  String _cupdate = DateFormat("dd MMM yyyy, EEE").format(DateTime.now());

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);


  String settime;
  Duration initialtimer = new Duration();
  String time;
  int stars;


  @override
  void initState() {
    super.initState();
    stars = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: spacikoColor.ColorPrimary,
        child: _mainWidget,
      ),
    );
  }


  get _mainWidget{
    return Container(
      child: Column(
        children: [

          SizedBox(height: 15),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp, color: spacikoColor.Colorwhite), iconSize: 25,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              Expanded(
                  child: Text('All Concepts',
                      style: TextStyle(color: spacikoColor.Colorwhite, fontFamily: 'poppins_regular', fontSize: 16))
              )
            ],
          ),

          SizedBox(height: 10),

          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: spacikoColor.Colorlihgt_green,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),

              child: ListView(
                padding: EdgeInsets.zero,

                children: [

                  /*material Date picker*/
                  Padding(
                    padding: EdgeInsets.only(top:10, left: 20, right: 20),

                    child: RaisedButton(
                      color: spacikoColor.Colorwhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('Material Date Picker :  $date', style: TextStyle(fontSize: 13, fontFamily: 'poppins_regular')),

                      onPressed: (){
                        _selectDate(context);
                      },
                    ),
                  ),


                  /*material time picker*/
                  Padding(
                    padding: EdgeInsets.only(top:5, left: 20, right: 20),
                    child: RaisedButton(
                      color: spacikoColor.Colorwhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('Material Time Picker :  $settime', style: TextStyle(fontSize: 13, fontFamily: 'poppins_regular')),

                      onPressed: (){
                        _pickTime(context);
                      },
                    ),
                  ),

                  /*Cupertino Date picker*/
                  Padding(
                    padding: EdgeInsets.only(top:10, left: 20, right: 20),
                    child: RaisedButton(
                      color: spacikoColor.Colorwhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('Cupertino Date Picker :  $_cupdate', style: TextStyle(fontSize: 13, fontFamily: 'poppins_regular')),
                      onPressed: (){
                        _cupertinoDatePicker(context);
                      },
                    ),
                  ),


                  /*Cupertino time picker*/
                  Padding(
                    padding: EdgeInsets.only(top:10, left: 20, right: 20),
                    child: RaisedButton(
                      color: spacikoColor.Colorwhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('Cupertino time Picker :  $time', style: TextStyle(fontSize: 13, fontFamily: 'poppins_regular')),

                      onPressed: (){
                        bottomSheet(context, timePicker());
                      },
                    ),
                  ),

                  /* Rating bar */
                  Padding(
                    padding: EdgeInsets.only(top:10, left: 20, right: 20),
                    child: RaisedButton(
                      color: spacikoColor.Colorwhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Text('Ratting Bar :  $stars', style: TextStyle(fontSize: 13, fontFamily: 'poppins_regular')),

                      onPressed: () async {
                        stars = await showDialog(
                              context: context,
                              builder: (_) => RatingDialog()
                        );
                          print('Selected rate stars: $stars');
                      },
                    ),
                  ),


                  /* Country code picker*/
                  Padding(
                    padding: EdgeInsets.only(top:10, left: 20, right: 20),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,

                          child: RaisedButton(
                            color: spacikoColor.Colorwhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text('Country Code Picker', style: TextStyle(fontSize: 13, fontFamily: 'poppins_regular')),
                            onPressed: () {

                            },
                          ),
                        ),

                        CountryCodePicker(
                          padding: EdgeInsets.only(left : 20),
                          onChanged: print,
                          initialSelection: 'IN',
                          favorite: ['+91','IN'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ],
                    ),
                  ),


                  /*Qr code Scanner*/
                  Padding(
                    padding: EdgeInsets.only(top:10, left: 20, right: 20),
                    child: RaisedButton(
                      color: spacikoColor.Colorwhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Text('QR Code Scanner', style: TextStyle(fontSize: 13, fontFamily: 'poppins_regular')),

                      onPressed: () async {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) => QrCodeScanner()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),

      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal,
              primaryColorDark: Colors.teal,
              accentColor: Colors.teal,
            ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child,
        );
      },
    );

    if(picked!=null && picked!=selectedDate){
      setState(() {
        selectedDate = picked;
        String Onlydate = new DateFormat("dd MMM yyyy, EEE").format(picked);
        date = '$Onlydate';
      });
    }
  }

  _cupertinoDatePicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context){

        return Container(
         height: MediaQuery.of(context).copyWith().size.height/3,
          color: spacikoColor.Colorwhite,

          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (picked){
              if (picked != null && picked != _cupSelectedDate)
                setState(() {
                  _cupSelectedDate = picked;
                  String Onlydate = new DateFormat("dd MMM yyyy, EEE").format(picked);
                  _cupdate = '$Onlydate';
                  print('DATE:::::$_cupdate');
                });
            },
            initialDateTime: _cupSelectedDate,
            minimumYear: 1950,
            maximumYear: 2030,

          ),
        );
      });
  }


  Future<Null> _pickTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context, initialTime: selectedTime);

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        settime = picked_s.format(context);
      });
  }

  Widget timePicker() {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hms,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialtimer,
      onTimerDurationChanged: (Duration changedtimer) {
        setState(() {
          initialtimer = changedtimer;
          time = changedtimer.inHours.toString() +
              ' hrs ' +
              (changedtimer.inMinutes % 60).toString() +
              ' mins ' +
              (changedtimer.inSeconds % 60).toString() +
              ' secs';
        });
      },
    );
  }


  Future<void> bottomSheet(BuildContext context, Widget child, {double height}) {
    return showModalBottomSheet(
        isScrollControlled: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13), topRight: Radius.circular(13))),

        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Container(
            height: height ?? MediaQuery.of(context).size.height / 3,
            child: child));
  }

}


class RatingDialog extends StatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
        size: 40,
      ),

      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Rate this post')),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStar(1),
          _buildStar(2),
          _buildStar(3),
          _buildStar(4),
          _buildStar(5),
        ],
      ),

      actions: [
        FlatButton(
          child: Text('CANCEL'),
          onPressed: Navigator.of(context).pop,
        ),

        FlatButton(
          child: Text('OK'),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop(_stars);
              print('NAVIGATION::::$_stars');
            });
          },
        )
      ],
    );
  }
}



