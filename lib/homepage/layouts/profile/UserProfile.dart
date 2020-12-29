import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';


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

                  // Container(
                  //   width: 100,
                  //   height: 100,
                  //   child: CircleAvatar(
                  //    backgroundImage: NetworkImage("https://autix.ch/wp-content/uploads/profile-placeholder.png"),
                  //   ),
                  // ),

                  _image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      _image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
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
                  getProfile();
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
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
      List<int> imageBytes = _image.readAsBytesSync();
      photoBase64 = base64Encode(imageBytes);
      print('BASE64::::$photoBase64');
    });
  }


  getProfile() async {
    print('GET::::$photoBase64');
    http.post("https://sam-app.vitecdevelopment.com/api/changeUserInfo",
      headers: {
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5MWU5MGVjZS1mYjE4LTQ4NzItOGI2ZS1iMGM5OTc5MDAzNzEiLCJqdGkiOiI5ODE1YThkMTI0OTZmNzdhMjRhNmJiNmZkY2U4ZWM5NzI0ZGJjYzc3ODU1ZWFhMmRjMjNmZjQwMDA3ZDE1NzM2YWYyYWFhNDE5ZGY4ZmIyNCIsImlhdCI6MTYwOTI0NjIwMiwibmJmIjoxNjA5MjQ2MjAyLCJleHAiOjE2NDA3ODIyMDIsInN1YiI6IjIwNCIsInNjb3BlcyI6W119.PyibIpwrxbakqosyKGKVAv5XSmseazBMFwpe1d0L3Sgw3QZekPzo0HoJZrbHt7VYNlzYO1WSY6sQwfIZWZpWo_jhEQa0Oq5ETskhgVk7lNMc_EBNOOfnjEH8V6MHGLUvvZnC0rij2f1-VIbAxrLBMx0zOUP4d7WUkJGBTpnypahS7z9G3lTtLTdeDgyKZLtsW94VgI1BDcvNgOTT8cnLWWNP8E-YKf7bKPj9uL-BsJ4-0zGiCfq3bEM4y018Rtn2sZ4YOOQqP7zUrFF-DRqPJuLHOETKItijjGnqOmpFpPfbaO0U0MXSqIc5uRvp88jtYndDxAvlvBrkDEGkSmOsBVgVIQOAFRLm5cD4uP-cuumNaAuCD4ylwDppv9Mwt23RyCZcoKH42QkK76lf5XXKdwd6t3UIT7XXodudbT0Op4xLNWyHYTsJFv3F5RvIa0-fPEUodi4foq9tgLGbPCmb4GkGpkQqW-tqGwIytm1ySxHcPeTKpz0iUYfUHOatp5gVs1_t4_4QL1qB9ThcZt5OY6nmZtP2NzQr_w5GVKGXHyjRp7RBJiunf6PzXD1znJ_YQhUIfqh-BrpzcfB7e1clIYabTRwA_cEpTWVNQQJd2L4JXmV81hlVq_-9dfP0zeCYwxPCuO-leRr7qzB-ucf5C7w6F8pncmpLSXHWAcS5SjU',
      },
      body: {'fullName': "p7cQUq7qkNRz78L3w2yRJA==", 'avatar': photoBase64}

    ).then((response) {
      print('SUCC::::${response.statusCode}');

      if (response.statusCode == 200) {
        print('CALLED::::;${json.decode(response.body)}');
      }
    });
  }


}
