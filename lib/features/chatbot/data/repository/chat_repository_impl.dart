

import 'package:health_care_application/features/chatbot/data/data_source/chat_data_source.dart';
import 'package:health_care_application/features/chatbot/data/models/message_model.dart';
import 'package:health_care_application/features/chatbot/domain/repository/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {

  final ChatDataSource _chatBotDataSource;

  ChatRepositoryImpl({required ChatDataSource chatBotDataSource}) : _chatBotDataSource = chatBotDataSource;

  @override
  Future<MessageModel> sendMessage(String content) async {
    return await _chatBotDataSource.sendMessage(content);
  }

}