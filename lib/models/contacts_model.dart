// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactsModel {
  String? id;
  String name;
  String? dateBorn;
  String? cpf;
  String phone;
  String? email;
  ContactsModel({
    this.id,
    required this.name,
    this.dateBorn,
    this.cpf,
    required this.phone,
    this.email,
  });

  ContactsModel copyWith({
    String? id,
    String? name,
    String? dateBorn,
    String? cpf,
    String? phone,
    String? email,
  }) {
    return ContactsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateBorn: dateBorn ?? this.dateBorn,
      cpf: cpf ?? this.cpf,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null && id!.isNotEmpty) '_id': id,
      'name': name.toUpperCase(),
      'dateBorn': dateBorn?.toUpperCase() ?? '',
      'cpf': cpf?.toUpperCase() ?? '',
      'phone': phone.toUpperCase(),
      'email': email?.toUpperCase() ?? '',
    };
  }

  factory ContactsModel.fromMap(Map<String, dynamic> map) {
    return ContactsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      dateBorn: map['dateBorn'] ?? '',
      cpf: map['cpf'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactsModel.fromJson(String source) =>
      ContactsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactsModel(id: $id, name: $name, dateBorn: $dateBorn, cpf: $cpf, phone: $phone, email: $email)';
  }

  @override
  bool operator ==(covariant ContactsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.dateBorn == dateBorn &&
        other.cpf == cpf &&
        other.phone == phone &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        dateBorn.hashCode ^
        cpf.hashCode ^
        phone.hashCode ^
        email.hashCode;
  }
}
