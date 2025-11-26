

import 'package:health_care_application/features/chatbot/data/models/message_model.dart';

abstract class ChatRepository {

  Future<MessageModel> sendMessage(String content);
}