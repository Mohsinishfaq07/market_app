class ChatMessageModel {
  final String message;
  final String senderId;

  ChatMessageModel({
    required this.message,
    required this.senderId,
  });

  // Convert a ChatMessageModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderId': senderId,
    };
  }

  // Create a ChatMessageModel from a Map
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      message: json['message'],
      senderId: json['senderId'],
    );
  }
}
