import 'package:chat_app/constants.dart';
class Message{
  final String message;
  final String owner;
  Message(this.message, this.owner);
  factory Message.fromJson(jsonData){
    return Message(jsonData[kMessage] , jsonData["owner"]);
  }
}