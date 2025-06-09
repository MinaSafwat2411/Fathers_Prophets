
class EventsModel {
  final String? name;
  final String? title;
  final String? image;
  final String? date;
  final String? docId;
  DateTime? dateTime;
  EventsModel({
    this.name,
    this.title,
    this.image,
    this.date,
    this.docId,
    this.dateTime
});

  factory EventsModel.fromJson(Map<String, dynamic> json,String id) {
    return EventsModel(
      name: json['name'],
      title: json['title'],
      image: json['image'],
      date: json['date'],
      docId: id,
      dateTime: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'image': image,
      'date': date,
      'docId': docId,
    };
  }
}