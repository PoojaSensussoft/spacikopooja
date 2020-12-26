import 'dart:async';
import 'dart:convert' show Encoding, json;
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacikopooja/model/note.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';
import 'ChatList.dart';


class MainchatScreen extends StatefulWidget {
  @override
  _MainchatScreenState createState() => _MainchatScreenState();
}


class _MainchatScreenState extends State<MainchatScreen> {
  TextEditingController textMessage = new TextEditingController();
  DatabaseReference databaseReference;
  Note item;
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String currentTime;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        ChatList(),

        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: spacikoColor.Colorwhite
                ),

                child: Text(
                  'Translate this conversation to english powered by google',
                  style: TextStyle(color: spacikoColor.ColorBlackLightText, fontFamily:'poppins_regular', fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),


              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: spacikoColor.Colorwhite,
                        border: Border.all(color: spacikoColor.ColorBlackLightText, width: 0.5)
                    ),
                    alignment: Alignment.center,
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: 35),
                    child: TextField(
                      controller: textMessage,
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                        hintText: 'Type Message...',
                        hintStyle: TextStyle(color: spacikoColor.ColorBlackLightText, fontSize: 16, fontFamily:'poppins_regular'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left:20, top: 15, bottom: 10, right: 10),
                      ),
                    ),
                  ),

                  GestureDetector(
                     onTap: (){
                       sendFcmMessage(textMessage.text);

                       if(textMessage.text.isNotEmpty) {
                         currentTime =
                             now.hour.toString() + ":" + now.minute.toString() +
                                 ":" + now.second.toString();

                         print('current_time:::::$currentTime');

                         databaseReference = FirebaseDatabase.instance.reference().child("Message").child('message_1_to_message_2');

                         databaseReference.push().set({
                           'message': textMessage.text,
                           'time': currentTime,
                           'is_sender': "true"
                         });

                         databaseReference =
                             FirebaseDatabase.instance.reference().child("Message").child('message_2_to_message_1');

                         databaseReference.push().set({
                           'message': textMessage.text,
                           'time': currentTime,
                           'is_sender': "false"
                         });
                         textMessage.clear();

                       }else{
                         Utility.showToast('Enter Message');
                       }
                     },

                    child: Container(
                      padding: EdgeInsets.only(left:10, top: 15, bottom: 10, right: 10),
                      alignment: Alignment.centerRight,

                      child: Image(
                        alignment: Alignment.centerRight,
                        width: 25,
                        height: 25,
                        image: AssetImage('image/ic_send_msg.png'),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }


  Future<bool> sendFcmMessage(String text) async {

    try{
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
      "Content-Type": "application/json",
      "Authorization":
      "key=AAAA8GKPRcg:APA91bEJqq2qkGNbg57T1XJu8BGxH_C1gszQXcBCPYLkHJy-LKMjW8nakl0rZqgJrqKKzHb0BJ9aRJ1Pi_U5EWorTgMOsxqLlWPCw9_Kze1KMpIfdwfdsYJL6K2gq2CJKe5oKCQ88Yj8",
      };

    var request = {
      'notification': {'title': "Spaciko Pooja App", 'body': text},
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'type': 'COMMENT'
      },
      'to': 'ftslcFufz0VPickdVziXh8:APA91bGZjJHoekm4vBHOudf58qQSbEeNTV0vqU8N2N7okU33kwItETe3F7jkpHsSWftqOc-yeIP_bUtR5otMVygjz3iYOPcxFn6WbZsyWUcFGOQsEhMHTKj-hFMDJj4yXwAn1TB6xtfz'
    };

    final response = await http.post(url, body: json.encode(request), encoding: Encoding.getByName('utf-8'), headers: header);

    if (response.statusCode == 200) {
      print("status:IF:::::");
      Utility.showToast("Message send successfully");
      return true;
    } else {
      print("status:ELSE:::::");
      return false;
    }

  } catch (e, s) {
  print('CATCH:::::$e');

  return false;
  }

  }

}

