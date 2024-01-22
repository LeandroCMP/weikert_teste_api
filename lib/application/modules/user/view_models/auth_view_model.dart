// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:weikert_teste_api/application/helpers/request_mapping.dart';

class AuthViewModel extends RequestMapping {
  String? user;
  String? password;

  AuthViewModel(String dataRequest) : super(dataRequest);

  @override
  void map() {
    user = data['user'];
    password = data['password'];
  }
}
