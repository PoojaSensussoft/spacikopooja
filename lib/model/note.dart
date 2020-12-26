import 'package:firebase_database/firebase_database.dart';

class Note {
  String _key;
  String _message;
  String _time;
  String _is_sender;

  Note(this._message, this._time, this._is_sender);

  Note.map(dynamic snapshot) {
    _message = snapshot.value["message"];
    _time = snapshot.value["time"];
    _is_sender = snapshot.value["is_sender"];
  }

  String get message => _message;
  String get time => _time;
  String get is_sender => _is_sender;


  set setMessage(name) {
    this._message = name;
  }

  set setTime(name) {
    this._time = name;
  }

  set setIssender(name) {
    this._is_sender = name;
  }

  Note.fromSnapshot(DataSnapshot snapshot) {
    _key = snapshot.key;
    _message = snapshot.value['message'];
    _time = snapshot.value['time'];
    _is_sender = snapshot.value['is_sender'];
  }


}
