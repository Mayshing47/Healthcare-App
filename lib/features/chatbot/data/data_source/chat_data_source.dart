import 'package:health_care_application/features/chatbot/data/models/message_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatDataSource {
  final String _apiKey;

  ChatDataSource({required String apiKey}) : _apiKey = apiKey;

  Future<MessageModel> sendMessage(String message) async {
    try {
      final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);
      final content = [Content.text(message)];
      final response = await model.generateContent(content);

      if (response.text == null) {
        throw Exception('Response text is null');
      }

      return MessageModel(
        content: response.text!,
        isUser: false,
        timeStamp: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
