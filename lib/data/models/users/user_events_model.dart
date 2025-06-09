class UserEventsModel {
  final List<String>? football;
  final List<String>? volleyball;
  final List<String>? bible;
  final List<String>? ritual;
  final List<String>? pingPong;
  final List<String>? choir;
  final List<String>? chess;
  final List<String>? doctrine;
  final List<String>? melodies;
  final List<String>? coptic;

  UserEventsModel({
    this.football,
    this.volleyball,
    this.bible,
    this.ritual,
    this.pingPong,
    this.choir,
    this.chess,
    this.doctrine,
    this.melodies,
    this.coptic,
});

  factory UserEventsModel.fromJson(Map<String, dynamic> json) {
    return UserEventsModel(
      football: List<String>.from(json['football']??[]),
      volleyball: List<String>.from(json['volleyball']??[]),
      bible: List<String>.from(json['bible']??[]),
      ritual: List<String>.from(json['ritual']??[]),
      pingPong: List<String>.from(json['pingPong']??[]),
      choir: List<String>.from(json['choir']??[]),
      chess: List<String>.from(json['chess']??[]),
      doctrine: List<String>.from(json['doctrine']??[]),
      melodies: List<String>.from(json['melodies']??[]),
      coptic: List<String>.from(json['coptic']??[]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'football': football,
      'volleyball': volleyball,
      'bible': bible,
      'ritual': ritual,
      'pingPong': pingPong,
      'choir': choir,
      'chess': chess,
      'doctrine': doctrine,
      'melodies': melodies,
      'coptic': coptic,
    };
  }
}