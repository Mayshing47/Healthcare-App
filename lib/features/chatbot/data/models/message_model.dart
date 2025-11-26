class MessageModel {
  final String content;
  final bool isUser;
  final DateTime timeStamp;

  MessageModel({
    required this.content,
    required this.isUser,
    required this.timeStamp,
  });
}
