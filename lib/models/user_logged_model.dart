// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weikert_teste_api/models/user_model.dart';

class UserLoggedModel {
  final UserModel? user;
  final String? token;

  UserLoggedModel({
    this.user,
    this.token,
  });

  UserLoggedModel copyWith({
    UserModel? user,
    String? token,
  }) {
    return UserLoggedModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  String toString() => 'UserLoggedModel(user: $user, token: $token)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'token': token,
    };
  }

  factory UserLoggedModel.fromMap(Map<String, dynamic> map) {
    return UserLoggedModel(
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoggedModel.fromJson(String source) =>
      UserLoggedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserLoggedModel other) {
    if (identical(this, other)) return true;

    return other.user == user && other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}
