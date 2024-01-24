import 'dart:convert';

class UserModel {
  final String? id;
  final String name;
  final String user;
  final String password;

  UserModel({
    this.id,
    required this.name,
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null && id!.isNotEmpty) '_id': id,
      'name': name.toUpperCase(),
      'user': user.toLowerCase(),
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      user: map['user'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id,  name: $name, user: $user, password: $password)';
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
      name: name ?? this.name,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.user == user &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ user.hashCode ^ password.hashCode;
  }
}
