import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:spacikopooja/homepage/layouts/chatSection/CustomChatBubble.dart';
import 'package:spacikopooja/model/chatMessage.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<chatMessage>items = List();
  chatMessage chatmessage;
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    getchatListData();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: () {
              setState(() {});
            },

            child: Padding(
              padding: EdgeInsets.all(15),

              child: items[index].is_sender==true? Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Flexible(
                        child: Container(
                          child: CustomPaint(
                            painter: CustomChatBubble(isOwn: true, color: spacikoColor.ColorLightChat),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(items[index].message, style: TextStyle(color: spacikoColor.Colorblack, fontFamily: 'poppins_regular',
                                  fontSize: 15)),
                            ),
                          ),

                          padding: EdgeInsets.only(left: 100),
                        ),
                      ),

                      Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(color: spacikoColor.ColorOpacity,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text('A', style: TextStyle(fontSize: 11, fontFamily: '',color: spacikoColor.Colorblack)),
                      ),
                    ],
                  )
              ) :

              Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(color: spacikoColor.ColorOpacity,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text('A', style: TextStyle(fontSize: 11, fontFamily: '',color: spacikoColor.Colorblack)),
                      ),

                      Flexible(
                        child: Container(
                          child: CustomPaint(
                              painter: CustomChatBubble(isOwn: false, color: spacikoColor.ColorLightChat),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(items[index].message, style: TextStyle(color: spacikoColor.Colorblack, fontFamily: 'poppins_regular',
                                    fontSize: 15)
                                ),
                              )
                          ),

                          margin: EdgeInsets.only(right: 100),
                        ),
                      ),
                    ],
                  )
              ),
            ),

          );
        },
      ),
    );
  }

  void getchatListData() {
    chatmessage = chatMessage("hello", "hello",false);
    final FirebaseDatabase database = FirebaseDatabase.instance;

    databaseReference = database.reference().child('Message');

    databaseReference.onChildAdded.forEach((element) =>{
      print("get_values_111:::::${element.snapshot.key}")

    });
  }
}

