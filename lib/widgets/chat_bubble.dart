import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key,required this.message});
  final Message message;
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only( right: 24),
      child: Align(
        alignment:  Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: kPrimaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8,bottom: 8 ,left: 8,right: 14),
            child: Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key,required this.message});
  final Message message;
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Align(
        alignment:  Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
          decoration: const BoxDecoration(

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: Color(0xff006d84),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8,bottom: 8 ,left: 8,right: 14),
            child: Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

}
