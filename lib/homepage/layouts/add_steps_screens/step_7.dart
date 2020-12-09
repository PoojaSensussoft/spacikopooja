import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  List<File> imageList = new List();
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
                onTap: (){
                  _showPicker(context);
                },
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

             child: Container(
               margin: EdgeInsets.only(left: 20, right: 20),
          //      child: GridView.count(
          //        padding: EdgeInsets.zero,
          //        shrinkWrap: true,
          //        physics: NeverScrollableScrollPhysics(),
          //        scrollDirection: Axis.vertical,
          //       crossAxisCount: 4,
          //
          //       children: List.generate(5, (index) {
          //         return Container(
          //           alignment: Alignment.center,
          //               child: Container(
          //                     decoration: BoxDecoration(color: spacikoColor.ColorPrimary),
          //                     height: 60,
          //                     width: 60,
          //                       child: imageList.length != 0
          //                           ? ClipRRect(
          //                         borderRadius: BorderRadius.circular(50),
          //                         child: Image.file(imageList[index], width: 100, height: 100, fit: BoxFit.fitHeight,),
          //                       ):
          //                       Container(decoration: BoxDecoration(color: Colors.grey[200],
          //                           borderRadius: BorderRadius.circular(50)), width: 60, height: 100,
          //                         child: Icon(Icons.camera_alt, color: Colors.grey[800]),
          //                       )
          //               )
          //
          //         );
          //       }),
          // ),

               child: Container(
                 height: 70,
                   width: 70,
                   child: _image!=null ?Image.file(_image) : null),
             ),
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
                  if(comemnt.text.isEmpty){
                    Utility.showToast("Please add Comment");
                  }else{
                    widget.onChangeFunction(widget.currentpage);
                  }
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
      padding: EdgeInsets.only(left: 20, right: 20, top: 25),

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


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[

                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),

                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  _imgFromCamera() async {
    File image = (await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50));

    setState(() {
      _image = image;
      isVisible = true;
      imageList.add(_image);
    });
  }

  _imgFromGallery() async {
    File image = (await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ));

    setState(() {
      _image = image;
      isVisible = true;
      imageList.add(_image);
    });
  }

}
