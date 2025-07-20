class ChatModel {
  final String text;
  final String senderUid;
  final int timestamp;
  bool isRead;
  final String key;

  ChatModel({
    required this.text,
    required this.senderUid,
    required this.timestamp,
    required this.isRead,
    required this.key
  });

  Map<String, dynamic> toMap() => {
    'text': text,
    'senderUid': senderUid,
    'timestamp': timestamp,
    'isRead': isRead,
  };

  factory ChatModel.fromMap(Map<String, dynamic> map,String key) => ChatModel(
    text: map['text'],
    senderUid: map['senderUid'],
    timestamp: map['timestamp'],
    isRead: map['isRead'],
    key: key
  );
}
