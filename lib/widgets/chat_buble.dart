import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../constant.dart';
import '../models/message.dart';


class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child:ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      )
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ChatBubble(
        clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
        backGroundColor: KPrimaryColor,
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),

    );
  }
}