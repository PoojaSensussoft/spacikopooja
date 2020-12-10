import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class SevenStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  SevenStep(this.currentpage,{this.onChangeFunction});

  @override
  _SevenStepState createState() => _SevenStepState();
}

class _SevenStepState extends State<SevenStep> {
  TextEditingController comemnt = new TextEditingController();
  File _image;
  List<Asset> imageList = new List();
  bool isVisible;

  @override
  void initState() {
    isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text('Use images to bring your space to life!',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, fontFamily: 'poppins_semibold', color: spacikoColor.Colorblack, height: 1.2,)),
            alignment: Alignment.center,
          ),


          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Text('Guests want to know what your space looks like. If you have photos, now\'s the time to share them! Don\'t worry- you can always come back later',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontFamily: 'poppins_regular', color: spacikoColor.ColorBlackLightText, height: 1.2,)),
            alignment: Alignment.center,
          ),

          SizedBox(height: 20),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: loadAssets,

                child: Container(
                  alignment: Alignment.center,
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: spacikoColor.Colorpink),
                    child: Image(image: AssetImage('image/ic_upload.png') ,height: 25, width: 25, color: spacikoColor.Colorwhite,)),
              ),

              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text('Upload Image',
                    style: TextStyle(fontSize: 14, fontFamily: 'poppins_medium', color: spacikoColor.Colorpink)),
                alignment: Alignment.center,
              ),
            ],
          ),

           Visibility(
             visible: isVisible,
               child:  Container(
                 margin: EdgeInsets.only(left: 25, right: 25),
                 child: buildGridView(),
                 padding: EdgeInsets.zero)
           ),

          containerComment(),

          SizedBox(height: 50),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 25, right: 25),
            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              child: Text("Continue",
                  style: TextStyle(fontSize: 18, fontFamily: "poppins_semibold", color: spacikoColor.Colorwhite)),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),

              onPressed: () {
                setState(() {

                  comemnt.text.isEmpty? Utility.showToast("Please add Comment"): widget.onChangeFunction(widget.currentpage);
                });
              },
            ),
          ),

        ],
      ),

    );
  }

  Widget containerComment(){
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),

      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(18),

        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 120,

          child: TextFormField(
            controller: comemnt,
            maxLines: null,
            cursorColor: spacikoColor.ColorPrimary,
            keyboardType: TextInputType.text,

            decoration: InputDecoration(
              hintText: 'Write comment here',
              hintStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

            ),
          ),
        ),
      ),
    );
  }


  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: imageList,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Ilma",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      imageList = resultList;
      imageList.length!=0 ? isVisible = true : isVisible = false;
      error = error;
    });
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      scrollDirection: Axis.vertical,

      children: List.generate(imageList.length, (index) {
        Asset asset = imageList[index];
        return Stack(
          children: [
            AssetThumb(
              asset: asset,
              width: 55,
              height: 55,
            ),

            Container(
              width: 55,
              height: 55,
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    imageList.removeAt(index);
                    imageList.length!=0 ? isVisible = true: isVisible = false;
                  });
                },

                child: Container(transform: Matrix4.translationValues(5.0, -5.0, 0.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: spacikoColor.Colorpink),
                  width: 17,
                  height: 17,
                  child: Icon(Icons.close_rounded, color: spacikoColor.Colorwhite, size: 15,),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

}
