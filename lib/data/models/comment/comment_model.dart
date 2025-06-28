class CommentModel {
  final String? id;
  final String authorId;
  final String content;
  final int timestamp;

  CommentModel({
    this.id,
    required this.authorId,
    required this.content,
    required this.timestamp,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json, String id) {
    return CommentModel(
      id: id,
      authorId: json['authorId'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
    'authorId': authorId,
    'content': content,
    'timestamp': timestamp,
  };
}
