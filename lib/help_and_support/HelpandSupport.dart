import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpandSupport extends StatefulWidget {
  @override
  _HelpandSupportState createState() => _HelpandSupportState();
}

class _HelpandSupportState extends State<HelpandSupport> {
  String text = '';
  String subject = '';

  final String number = "123456789";
  final String email = "dancamdev@example.com";

  String message = 'hello';
  var phone = '1234567890';

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'smith@example.com',
      queryParameters: {
        'subject': 'Example Subject & Symbols are allowed!'
      }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: spacikoColor.ColorPrimary,
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp,
                      color: spacikoColor.Colorwhite),
                  iconSize: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      'Help and Support',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: spacikoColor.Colorwhite,
                          fontFamily: 'poppins_semibold'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                    color: spacikoColor.Colorlihgt_green,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),

                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    FlatButton(color: spacikoColor.ColorPrimary,
                      child: Text('Share Text',
                          style: TextStyle(fontSize: 14, fontFamily: 'poppins_regular', color: spacikoColor.Colorwhite)),

                      onPressed: () async => await _shareText(),
                    ),

                    FlatButton(color: spacikoColor.ColorPrimary,
                      child: Text('Share Image',
                          style: TextStyle(fontSize: 14, fontFamily: 'poppins_regular', color: spacikoColor.Colorwhite)),

                      onPressed: () async => await _shareImage(),
                    ),

                    FlatButton(color: spacikoColor.ColorPrimary,
                      child: Text('Share Multiple Images',
                          style: TextStyle(fontSize: 14, fontFamily: 'poppins_regular', color: spacikoColor.Colorwhite)),

                      onPressed: () async => await _shareMultipleImage(),
                    ),

                    FlatButton(color: spacikoColor.ColorPrimary,
                      child: Text('Share Image from url',
                          style: TextStyle(fontSize: 14, fontFamily: 'poppins_regular', color: spacikoColor.Colorwhite)),

                      onPressed: () async => await _shareUrlFile(),

                   /*   onPressed: (){
                        _makePhoneCall('tel: 1234567890');
                      },*/
                    ),

                    FlatButton(color: spacikoColor.ColorPrimary,
                      child: Text('User Intent Call service',
                          style: TextStyle(fontSize: 14, fontFamily: 'poppins_regular', color: spacikoColor.Colorwhite)),

                        onPressed: (){
                          _makePhoneCall('tel: 1234567890');
                        }
                    ),

                    FlatButton(color: spacikoColor.ColorPrimary,
                        child: Text('User Intent Gmail service',
                            style: TextStyle(fontSize: 14, fontFamily: 'poppins_regular', color: spacikoColor.Colorwhite)),

                        onPressed: (){
                          launch(_emailLaunchUri.toString());
                        }
                    ),

                    FlatButton(color: spacikoColor.ColorPrimary,
                        child: Text('User Intent WhatsApp Send', style: TextStyle(fontSize: 14,
                            fontFamily: 'poppins_regular', color: spacikoColor.Colorwhite)),

                        onPressed: () async {
                          var whatsappUrl ="whatsapp://send?phone=$phone";
                          await canLaunch(whatsappUrl)? launch(whatsappUrl):
                              Utility.showToast("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                        }
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _shareText() async {
    try {
      Share.text('my text title',
          'This is my text to share with other applications.', 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImage() async {
    try {
      ByteData byteData = await rootBundle.load('image/splash.jpg');
      await Share.file("esys image", 'esys.png', byteData.buffer.asUint8List(), 'image/jpg', text: 'My share image text!');

    } catch (e) {
      print('error: $e');
    }
  }


  Future<void> _shareMultipleImage() async {
    try {
      ByteData byteData = await rootBundle.load('image/splash.jpg');
      ByteData bytedate1 = await rootBundle.load('image/splash.jpg');

      await Share.files("esys image",
          {'esys.png': bytedate1.buffer.asUint8List(),
          'bluedan.png': byteData.buffer.asUint8List(),}, 'image/jpg', text: 'My share image text!');

    } catch (e) {
      print('error: $e');
    }
  }


  Future<void>_shareUrlFile() async{
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          'https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg'));

      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }


  //making call
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      await launch(url);

    } else {
      Utility.showToast('Could not launch $url');
    }
  }

}
