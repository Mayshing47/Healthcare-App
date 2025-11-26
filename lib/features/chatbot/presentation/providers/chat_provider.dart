import 'package:flutter/foundation.dart';
import 'package:health_care_application/features/chatbot/domain/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:health_care_application/features/chatbot/data/models/message_model.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepository _chatRepository;

  ChatProvider({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  List<MessageModel> _messages = [];

  List<MessageModel> get messages => _messages;

  Future<void> sendMessage(String message) async {
    final userMessage = MessageModel(
      content: message,
      isUser: true,
      timeStamp: DateTime.now(),
    );
    _messages.add(userMessage);
    notifyListeners();

    try {
      final response = await _chatRepository.sendMessage(message);
      _messages.add(response);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to send message: $e');
      }
      _messages.add(MessageModel(
          content: 'Error: $e', isUser: false, timeStamp: DateTime.now()));
      notifyListeners();
    }
  }
}
