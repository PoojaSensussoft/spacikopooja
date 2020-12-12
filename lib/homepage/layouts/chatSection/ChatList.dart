import 'package:flutter/cupertino.dart';
import 'package:spacikopooja/homepage/layouts/chatSection/CustomChatBubble.dart';
import 'package:spacikopooja/model/ChatModel.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<ChatModel> _list = [
    ChatModel("Hello hjfhfjh jndjfhdjf nbfdjhfjdhf dfhdjfhdj jfhdjfhjdhfdjhfdjhfjfhj!dkfjdkfkdjkfdkfkfkd", "me"),
    ChatModel("Hello!vre krnernrjkrjtjrt", "sender"),
    ChatModel("How are You?", "me"),
    ChatModel("I am Fine!", "sender"),
    ChatModel("How are you?", "sender"),
    ChatModel("How are you?", "sender"),
    ChatModel("How are you?", "sender"),
    ChatModel("How are you?", "sender"),
    ChatModel("How are you?", "sender"),
    ChatModel("How are you?", "sender"),
    ChatModel("How are you?", "sender"),
    ChatModel("I am good!", "me")
  ];


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: _list.length,
        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: () {
              setState(() {});
            },

            child: Padding(
              padding: EdgeInsets.all(15),

              child: _list[index].type=="me"? Container(
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
                              child: Text(_list[index].message, style: TextStyle(color: spacikoColor.Colorblack, fontFamily: 'poppins_regular',
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
                                child: Text(_list[index].message, style: TextStyle(color: spacikoColor.Colorblack, fontFamily: 'poppins_regular',
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
}
