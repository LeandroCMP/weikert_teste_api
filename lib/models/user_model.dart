import 'dart:convert';

import 'package:uuid/uuid.dart';

class UserModel {
  final String? id;
  final String idGroup;
  final String name;
  final String user;
  final String email;
  final String password;
  final String cpfOrCnpj;
  final String dateBorn;
  final String phone;
  final int paymentDay;
  final int userLevel;
  UserModel({
    this.id,
    required this.idGroup,
    required this.name,
    required this.user,
    required this.email,
    required this.password,
    required this.cpfOrCnpj,
    required this.dateBorn,
    required this.phone,
    required this.paymentDay,
    required this.userLevel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null && id!.isNotEmpty) '_id': id,
      'idGroup': idGroup.isNotEmpty ? idGroup : Uuid().v4(),
      'name': name.toUpperCase(),
      'user': user.toLowerCase(),
      'email': email.toLowerCase(),
      'password': password,
      'cpfOrCnpj': cpfOrCnpj,
      'dateBorn': dateBorn,
      'phone': phone,
      'paymentDay': paymentDay,
      'userLevel': userLevel,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      idGroup: map['idGroup'] ?? '',
      name: map['name'] ?? '',
      user: map['user'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      cpfOrCnpj: map['cpfOrCnpj'] ?? '',
      dateBorn: map['dateBorn'] ?? '',
      phone: map['phone'] ?? '',
      paymentDay: map['paymentDay'] ?? 0,
      userLevel: map['userLevel'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, idGroup: $idGroup, name: $name, user: $user, email: $email, password: $password, cpfOrCnpj: $cpfOrCnpj, dateBorn: $dateBorn, phone: $phone, paymentDay: $paymentDay, userLevel: $userLevel)';
  }

  UserModel copyWith({
    String? id,
    String? idGroup,
    String? name,
    String? user,
    String? email,
    String? password,
    String? cpfOrCnpj,
    String? dateBorn,
    String? phone,
    int? paymentDay,
    int? userLevel,
  }) {
    return UserModel(
      id: id ?? this.id,
      idGroup: idGroup ?? this.idGroup,
      name: name ?? this.name,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      cpfOrCnpj: cpfOrCnpj ?? this.cpfOrCnpj,
      dateBorn: dateBorn ?? this.dateBorn,
      phone: phone ?? this.phone,
      paymentDay: paymentDay ?? this.paymentDay,
      userLevel: userLevel ?? this.userLevel,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idGroup == idGroup &&
        other.name == name &&
        other.user == user &&
        other.email == email &&
        other.password == password &&
        other.cpfOrCnpj == cpfOrCnpj &&
        other.dateBorn == dateBorn &&
        other.phone == phone &&
        other.paymentDay == paymentDay &&
        other.userLevel == userLevel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idGroup.hashCode ^
        name.hashCode ^
        user.hashCode ^
        email.hashCode ^
        password.hashCode ^
        cpfOrCnpj.hashCode ^
        dateBorn.hashCode ^
        phone.hashCode ^
        paymentDay.hashCode ^
        userLevel.hashCode;
  }
}
