import 'package:firebase_database/firebase_database.dart';

class chatMessage {
  String key;
  String message;
  String time;
  bool is_sender;

  chatMessage(this.message, this.time, this.is_sender);

  chatMessage.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        message = snapshot.value["message"],
        time = snapshot.value["time"],
        is_sender = snapshot.value["is_sender"];

  toJson() {
    return {
      "message": message,
      "time": time,
      "is_sender": is_sender,
    };
  }
}
