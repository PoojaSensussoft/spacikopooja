import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _currentDate;

  @override
  Widget build(BuildContext context) {
    return CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
      },

      weekendTextStyle: TextStyle(color: spacikoColor.ColorBlackLightText),
      headerTextStyle: TextStyle(color: spacikoColor.ColorBlackLightText, fontSize: 18, fontFamily: 'poppins_medium'),
      daysTextStyle: TextStyle(color: spacikoColor.ColorBlackLightText, fontSize: 16,fontFamily: 'poppins_regular'),
      selectedDayTextStyle: TextStyle(color: spacikoColor.Colorwhite, fontSize: 16,fontFamily: 'poppins_regular'),
      weekdayTextStyle: TextStyle(color: spacikoColor.ColorBlackLightText, fontSize: 16,fontFamily: 'poppins_regular'),
      weekDayMargin: EdgeInsets.only(bottom: 10),
      leftButtonIcon: Icon(Icons.arrow_back_ios_outlined, color: spacikoColor.Colorpink),
      rightButtonIcon: Icon(Icons.arrow_forward_ios_outlined, color: spacikoColor.Colorpink),
      selectedDayButtonColor: spacikoColor.Colorpink,
      selectedDayBorderColor: spacikoColor.Colorpink,
      todayButtonColor: spacikoColor.Colorpink,
      headerTitleTouchable: true,
      height: 420.0,
      selectedDateTime: _currentDate,
      daysHaveCircularBorder: true,
      markedDateShowIcon: false,
    );
  }
}
