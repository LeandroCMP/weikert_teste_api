// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weikert_teste_api/models/subjects_model.dart';

class ClientModel {
  String? id;
  String name;
  String phone;
  List<SubjectsModel> subjects;
  ClientModel({
    this.id,
    required this.name,
    required this.phone,
    required this.subjects,
  });

  ClientModel copyWith({
    String? id,
    String? name,
    String? phone,
    List<SubjectsModel>? subjects,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      subjects: subjects ?? this.subjects,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null && id!.isNotEmpty) '_id': id,
      'name': name.toUpperCase(),
      'phone': phone.toUpperCase(),
      'subjects': subjects.map((sub) => sub.toMap()).toList(),
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      subjects: List<SubjectsModel>.from(
        (map['subjects'].map<SubjectsModel>(
          (subject) => SubjectsModel.fromMap(subject),
        )),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClientModel(id: $id, name: $name, subjects: $subjects)';
  }

  @override
  bool operator ==(covariant ClientModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.subjects == subjects;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ phone.hashCode ^ subjects.hashCode;
  }
}
