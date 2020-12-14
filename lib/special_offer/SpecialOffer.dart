import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ListLayoutScrren.dart';

class SpecialOffer extends StatefulWidget {
  @override
  _SpecialOfferState createState() => _SpecialOfferState();
}

class _SpecialOfferState extends State<SpecialOffer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(left: 10, right: 10),

      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListLayoutScreen();

          }),
    );
  }
}
