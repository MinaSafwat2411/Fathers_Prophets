class EventAttendanceModel {
  final List<String>? football;
  final List<String>? volleyball;
  final List<String>? pingPong;
  final List<String>? chess;
  final List<String>? melodies;
  final List<String>? choir;
  final List<String>? ritual;
  final List<String>? coptic;
  final List<String>? doctrine;
  final List<String>? bible;
  final List<String>? pray;
  final List<String>? praise;

  EventAttendanceModel({
    this.football,
    this.volleyball,
    this.pingPong,
    this.chess,
    this.melodies,
    this.choir,
    this.ritual,
    this.coptic,
    this.doctrine,
    this.bible,
    this.pray,
    this.praise,
});

  factory EventAttendanceModel.fromJson(Map<String, dynamic> json) {
    return EventAttendanceModel(
      football: (json['football'] as List<dynamic>?)?.map((e) => e as String).toList(),
      volleyball: (json['volleyball'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pingPong: (json['pingPong'] as List<dynamic>?)?.map((e) => e as String).toList(),
      chess: (json['chess'] as List<dynamic>?)?.map((e) => e as String).toList(),
      melodies: (json['melodies'] as List<dynamic>?)?.map((e) => e as String).toList(),
      choir: (json['choir'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ritual: (json['ritual'] as List<dynamic>?)?.map((e) => e as String).toList(),
      coptic: (json['coptic'] as List<dynamic>?)?.map((e) => e as String).toList(),
      doctrine: (json['doctrine'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bible: (json['bible'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pray: (json['pray'] as List<dynamic>?)?.map((e) => e as String).toList(),
      praise: (json['praise'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'football': football?.map((e) => e).toList(),
      'volleyball': volleyball?.map((e) => e).toList(),
      'pingPong': pingPong?.map((e) => e).toList(),
      'chess': chess?.map((e) => e).toList(),
      'melodies': melodies?.map((e) => e).toList(),
      'choir': choir?.map((e) => e).toList(),
      'ritual': ritual?.map((e) => e).toList(),
      'coptic': coptic?.map((e) => e).toList(),
      'doctrine': doctrine?.map((e) => e).toList(),
      'bible': bible?.map((e) => e).toList(),
      'pray': pray?.map((e) => e).toList(),
      'praise': praise?.map((e) => e).toList(),
    };
  }
}