import 'package:weikert_teste_api/application/helpers/request_mapping.dart';

class RegisterNewUserViewModel extends RequestMapping {
  RegisterNewUserViewModel(String dataRequest) : super(dataRequest);
  String? name;
  String? user;
  String? email;
  String? password;
  String? cpfOrCnpj;
  String? dateBorn;
  String? phone;
  int? paymentDay;
  int? userLevel;
  @override
  void map() {
    name = data['name'];
    user = data['user'];
    email = data['email'];
    password = data['password'];
    cpfOrCnpj = data['cpfOrCnpj'];
    dateBorn = data['dateBorn'];
    phone = data['phone'];
    paymentDay = data['paymentDay'];
    userLevel = data['userLevel'];
  }
}
