import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class TermsCond extends StatefulWidget {
  @override
  _TermsCondState createState() => _TermsCondState();
}

class _TermsCondState extends State<TermsCond> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: spacikoColor.ColorPrimary,
          ),
        ),
        body: Center(
          child: Text("Coming Soon!", style: TextStyle(fontSize: 16, fontFamily: "poppins_regular", color: spacikoColor.Colorblack),),
        ),
      ),
    );
  }
}
