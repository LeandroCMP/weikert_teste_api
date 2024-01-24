// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubjectsModel {
  final String? id;
  final String subject;

  const SubjectsModel({
    this.id,
    required this.subject,
  });

  SubjectsModel copyWith({
    String? id,
    String? subject,
  }) {
    return SubjectsModel(
      id: id ?? this.id,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'subject': subject,
    };
  }

  factory SubjectsModel.fromMap(Map<String, dynamic> map) {
    return SubjectsModel(
      id: map["id"] ?? '',
      subject: map["subject"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectsModel.fromJson(String source) =>
      SubjectsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubjectsModel(id: $id, subject: $subject)';

  @override
  bool operator ==(covariant SubjectsModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.subject == subject;
  }

  @override
  int get hashCode => id.hashCode ^ subject.hashCode;
}
