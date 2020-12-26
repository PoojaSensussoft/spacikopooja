import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacikopooja/homepage/layouts/chatSection/CustomChatBubble.dart';
import 'package:spacikopooja/model/chatMessage.dart';
import 'package:spacikopooja/model/note.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  DatabaseReference databaseReference;
  final notesReference = FirebaseDatabase.instance.reference().child('Message').child('message_1_to_message_2');
  StreamSubscription<Event> _onNoteAddedSubscription;
  List<Note> items1;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // getchatListData();

    items1 = new List();
    _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);
  }

  void _onNoteAdded(Event event) {
    setState(() {
      items1.add(new Note.fromSnapshot(event.snapshot));
      print('LIST_OF_ITEMS:::::${items1.length}');
    });
  }


  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
          () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );
    return Flexible(
      child: ListView.builder(
        controller: _controller,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: items1.length,
        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: () {
              setState(() {

              });
            },

            child: Padding(
              padding: EdgeInsets.all(15),

              child: items1[index].is_sender=="true"? Container(
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
                              child: Text('${items1[index].message??''}',
                                  style: TextStyle(color: spacikoColor.Colorblack, fontFamily: 'poppins_regular',
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
                                child: Text(items1[index].message??'', style: TextStyle(color: spacikoColor.Colorblack,
                                    fontFamily: 'poppins_regular', fontSize: 15)
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

}

