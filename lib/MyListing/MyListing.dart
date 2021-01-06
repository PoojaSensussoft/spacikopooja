import 'package:flutter/material.dart';
import 'package:spacikopooja/MyListing/StartActivityForResult.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class MyListing extends StatefulWidget {
  @override
  _MyListingState createState() => _MyListingState();
}

class _MyListingState extends State<MyListing> {
  String strData = '';

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
                  icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),

                Expanded(
                  child: Text("StartActivityForResult", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: spacikoColor.Colorwhite, fontFamily: 'poppins_semibold')),
                ),
              ],
            ),

            SizedBox(height: 15),
            
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: spacikoColor.Colorlihgt_green,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),

                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text('This is Text : $strData', style: TextStyle(fontFamily: '', fontSize: 14, color: spacikoColor.Colorblack)),

                      SizedBox(height: 30),

                      RaisedButton(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                          color: spacikoColor.Colorwhite,
                          child: Text('Start Activity Result', style: TextStyle(color: spacikoColor.Colorblack, fontSize: 14, fontFamily: 'poppins_regular')),

                          onPressed: (){
                          _startActivity();
                        },
                      ),
                    ],

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _startActivity() async {
    Map result = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
      return new StartActivityForResult();
    }));

    if(result!=null && result.containsKey('item')){
      setState(() {
        strData = result['item'];
        print('print:::$strData');
      });
    }
  }

}




