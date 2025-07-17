class ChatbotModel {
  final String message;
  final bool sender;
  final DateTime time;

  ChatbotModel({required this.message, required this.sender, required this.time});

  factory ChatbotModel.fromJson(Map<String, dynamic> json) => ChatbotModel(
    message: json["message"],
    sender: json["sender"],
    time: DateTime.parse(json["time"]),
  );
  Map<String, dynamic> toJson() => {
    "message": message,
    "sender": sender,
    "time": time.toIso8601String(),
  };
}