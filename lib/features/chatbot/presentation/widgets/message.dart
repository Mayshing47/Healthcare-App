import 'package:flutter/material.dart';
import 'package:health_care_application/features/chatbot/data/models/message_model.dart';
import 'package:intl/intl.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15).copyWith(
        left: messageModel.isUser ? 100 : 10,
        right: messageModel.isUser ? 10 : 100,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: messageModel.isUser ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: messageModel.isUser ? const Radius.circular(10): Radius.zero,
          bottomRight: messageModel.isUser ? Radius.zero : const Radius.circular(10),
          topRight: Radius.circular(10),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(messageModel.content, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: messageModel.isUser ? Colors.white : Colors.black,
          ),),
          Text(getFormattedDate(), style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: messageModel.isUser ? Colors.white : Colors.black,
          ),
          ),
        ],
      ),
    );
  }

  String getFormattedDate() {
    final formatter = DateFormat('HH:mm a');
    return formatter.format(messageModel.timeStamp);
  }
}
