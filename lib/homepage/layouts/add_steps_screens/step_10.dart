import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacikopooja/model/ModelClass.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class TenthStep extends StatefulWidget {
  Function(int) onChangeFunction;
  var currentpage;

  TenthStep(this.currentpage,{this.onChangeFunction});

  @override
  _TenthStepState createState() => _TenthStepState();
}

class _TenthStepState extends State<TenthStep> {
  List<File> _images = [];
  final picker = ImagePicker();


  Future getImage(int index) async {
    final image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _images[index] = File(image.path);
      print((image.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Row(children: <Widget>[
              GestureDetector(
                onTap: () {
                  getImage(index);
                },

                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5, top: 10),
                  child: Container(
                    height: 100.0,
                    width: 100.0,

                    decoration: BoxDecoration(
                      border: Border.all(),

                      image: DecorationImage(
                        image: _images.length == 0
                            ? AssetImage('image/facebook.png')
                            : FileImage(_images[index]),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
              ),
            ]);
          }),

    );
  }
}
