
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class HelpandSupport extends StatefulWidget {
  @override
  _HelpandSupportState createState() => _HelpandSupportState();
}

class _HelpandSupportState extends State<HelpandSupport> {
  String text = '';
  String subject = '';

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
                  icon: Icon(Icons.arrow_back_ios_sharp, color: spacikoColor.Colorwhite), iconSize: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Text('Help and Support', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: spacikoColor.Colorwhite, fontFamily: 'poppins_semibold'),
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
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                ),


                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      FlatButton(
                        color: spacikoColor.ColorPrimary,
                        child: Text('Share Text', style: TextStyle(fontSize: 14,
                            fontFamily: 'poppins_regular',color: spacikoColor.Colorwhite)),

                        onPressed: (){
                          setState(() {
                            Share.share(
                                'check out my website https://protocoderspoint.com/');
                          });
                        },
                      ),

                      SizedBox(height: 15),

                      FlatButton(
                        color: spacikoColor.ColorPrimary,
                        child: Text('Share Image', style: TextStyle(fontSize: 14,
                            fontFamily: 'poppins_regular',color: spacikoColor.Colorwhite)),

                        onPressed: () async {
                          // Directory dir = await getApplicationDocumentsDirectory();
                          //   // Share.shareFiles(['${dir.path}/SampleImage.png'], text: 'Great picture');
                          //
                          //   var request = await HttpClient().getUrl(Uri.parse('https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg'));
                          //   var response = await request.close();
                          //   Uint8List bytes = await consolidateHttpClientResponseBytes(response);
                          //   await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
                        },
                      ),
                    ],

                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
