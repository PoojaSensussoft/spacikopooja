import 'package:flutter/material.dart';
import 'package:spacikopooja/booking/Previous.dart';
import 'package:spacikopooja/booking/Upcoming.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: spacikoColor.ColorPrimary,

        body: Column(
          children: [
            SizedBox(height: 10),

            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp, color: spacikoColor.Colorwhite), iconSize: 25,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Text('Booking', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: spacikoColor.Colorwhite, fontFamily: 'poppins_semibold'),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Container(
             child: TabBar(
               indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: spacikoColor.Colorpink, width: 5.0),
                  insets: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
                ),

                tabs: [
                  Padding(
                    padding: EdgeInsets.all(12),
                      child: Text("Upcoming", style: TextStyle(fontSize: 17, fontFamily: 'poppins_medium', color: spacikoColor.Colorwhite))),

                  Padding(
                      padding: EdgeInsets.all(12),
                      child: Text("Previous", style: TextStyle(fontSize: 17, fontFamily: 'poppins_medium', color: spacikoColor.Colorwhite))),
                ],
              ),
            ),


            Expanded(
            child: Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:
                     Radius.circular(30), topRight: Radius.circular(30)),
                     color: spacikoColor.Colorlihgt_green),

                child: TabBarView(
                      children: [
                        Upcoming(),

                        Previous(),
                      ],
                    ),
            )
            )
          ],
        ),
      ),
    );
  }
}
