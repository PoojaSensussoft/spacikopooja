import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacikopooja/model/ListData.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File _image;
  String photoBase64;
  TextEditingController userName = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          SizedBox(height: 20),

          GestureDetector(
            onTap: (){
              _showPicker(context);
            },

            child: Container(
              width: 100,
              height: 100,

              child: Stack(
                children: <Widget>[

                  _image != null ?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(_image, width: 100, height: 100, fit: BoxFit.fitHeight),
                  )
                      : Container(
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,
                    child: Icon(Icons.camera_alt, color: Colors.grey[800],
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,

                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: spacikoColor.ColorPrimary,
                          borderRadius:BorderRadius.circular(100)
                      ),

                      child: Icon(
                        Icons.edit, color: Colors.white, size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            margin: EdgeInsets.only(top: 35),

            child: Theme(

              data: new ThemeData(
                primaryColor: spacikoColor.ColorPrimary,
                primaryColorDark: spacikoColor.ColorPrimary,
              ),

              child: TextFormField(
                controller: userName,
                cursorColor: spacikoColor.ColorPrimary,
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  labelText: "User Name",
                  labelStyle: TextStyle(fontSize: 16, fontFamily: "poppins_regular"),

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: spacikoColor.ColorPrimary)),

                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: spacikoColor.ColorPrimary)),
                ),

              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.only(left: 25, right: 25, top: 50),

            child: RaisedButton(
              color: spacikoColor.ColorPrimary,
              child: Text("Update Profile", style: TextStyle(fontSize: 18, fontFamily: "poppins_medium", color: spacikoColor.Colorwhite),),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),

              onPressed: () async {
                if(userName.text.isEmpty){
                  Utility.showToast("Enter User name");
                }else{
                  uploadImage(_image);
                }
              },
            ),
          ),
        ],
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
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 1,maxHeight: 450.0,
        maxWidth: 450.0
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 5,maxHeight: 450.0, maxWidth: 450.0
    );

    setState(() {
      _image = image;
      List<int> imageBytes = _image.readAsBytesSync();
      photoBase64 = base64Encode(imageBytes);
      print('BASE64::::$photoBase64');
    });
  }
  

  Future<Datum> uploadImage(File imageFile) async {

    final StringBuffer url = new StringBuffer("https://sam-app.vitecdevelopment.com/api/changeUserInfo");

    Dio dio = new Dio();
    var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5MWU5MGVjZS1mYjE4LTQ4NzItOGI2ZS1iMGM5OTc5MDAzNzEiLCJqdGkiOiI4ODViNDc1YjA0YzM1OThiZWVkNjQwNDBkMGFiMTMxYTE2MjhiNzRiYWYxYjViMjRjN2M1Nzg4YjU5ZmRmNTk4MmM0ZWYzMmZmZWE5NTllOCIsImlhdCI6MTYwOTMwODUyNCwibmJmIjoxNjA5MzA4NTI0LCJleHAiOjE2NDA4NDQ1MjQsInN1YiI6IjIwNCIsInNjb3BlcyI6W119.KGZHR3tYRuYCi-3XexOoVhd3-Aa_gCmRV_ETuszqumgghF5cWPJYG77GQnCE9BV5xfma3RSgMuNakgM9ZG1m_SCMF94Zz-BjglBgypX_p5CpT1eCOBt4Fg2YoxP7uHyov5-0e1o0z6mCGuWDjE-PhxPMJwV-rvsDtVbo4Je-vRvAsaekkJvcxTsBGzxMYL-m7_EKYp044UDuSBxnShb1hb7ISwWcHRKhSl1oK8dBzdRnq6XK4sqsFEHYYE57AnNwPcgGG8k2jbz54WkaDXEJcDvO1rR-ztFYzWmTMoYsM8NnBgRPLg5kiPacEaJukh1T2GMwZdAUs4xIQ_vCzls9w0DjdB9AFplW1Oi904ifMWxNUL0jl8h2-5EtScPfbzLVUYXiJUHW_Y_xR68pyxsrcIXoB-gMFKUZaMgbhXFrE3iV-KUvzlo6sD0KEeuyTEjsEdXAYnJOa-NjTfq7eIKYsFTiqLPcV-hPDxofv4zp2dbdHldFQgnLl_Va5uoy5Gmp1E2-OMouaceu3maKYFIOSsHP_z8a0l3DD_6aNx4V7RyRLrCpqhRZsF_QR-cFHcbU8aLJWPn-VwiYYj3IOvTwYmtLBD76upzKNwTx1Pp88vzGZh3gwknPSE4kLHRbLz24tiqcah0MM_SQO36iXchdZOkAdagghIlxTE63dc_Y40U';
    try {
      FormData formData = FormData.fromMap(
        { "fullName": "p7cQUq7qkNRz78L3w2yRJA==",
          "avatar": await MultipartFile.fromFile(imageFile.path)
        },
      );

      if (token != null) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }
      var response = await dio.post(url.toString(), data: formData);
      print(response.data);

      if(response.data['success']){
        Utility.showToast(response.data['message']);
        Navigator.pop(context);

      }else{
        Utility.showToast(response.data['message']);
      }
      return Future.value(response.data);

    } on DioError catch (e) {
      Utility.showToast(e.message);
    }
  }
}
