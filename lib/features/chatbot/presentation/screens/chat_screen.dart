import 'package:flutter/material.dart';
import 'package:health_care_application/features/chatbot/presentation/providers/chat_provider.dart';
import 'package:health_care_application/features/chatbot/presentation/widgets/chat_text_field.dart';
import 'package:health_care_application/features/chatbot/presentation/widgets/message.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _messageController;

  @override
  void initState() {
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    return ListView.builder(
                      reverse: true,
                      itemBuilder: (context, index) {
                        final message = chatProvider.messages.reversed.toList()[index];
                        return Message(messageModel: message);
                      },
                      itemCount: chatProvider.messages.length,
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                    child: ChatTextField(
                        labelText: 'send a message',
                        controller: _messageController)),
                IconButton(
                    onPressed: () {
                      final chatProvider =
                      Provider.of<ChatProvider>(context, listen: false);
                      chatProvider.sendMessage(_messageController.text);
                      _messageController.clear();
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }
}