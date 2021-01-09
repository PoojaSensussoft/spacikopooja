import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class QrCodeScanner extends StatefulWidget {
  @override
  _QrCodeScannerState createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: spacikoColor.ColorPrimary,

        child: Column(
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
                    child: Text('Qr Code Scanner',textAlign: TextAlign.center,
                        style: TextStyle(color: spacikoColor.Colorwhite, fontFamily: 'poppins_regular', fontSize: 16))
                ),

                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: false,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_sharp, color: spacikoColor.Colorwhite), iconSize: 25,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],),

            SizedBox(height: 15),
            
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: spacikoColor.Colorlihgt_green,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),

                child: Column(
                  children: [
                    SizedBox(height: 15),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      color: spacikoColor.Colorwhite,
                      child: Text('scan qr code'.toUpperCase(), style: TextStyle(fontFamily: 'poppins_regular', fontSize: 14, color: spacikoColor.Colorblack),),

                      onPressed: (){
                         scan();
                      },
                    )
                  ],
                ),

              ),
            )
          ],
        ),
      ),
    );
  }

  Future scan() async {
    try{
      // String barcode = await BarcodeScanenr.scan();

    }catch(e){

    }
  }

}
