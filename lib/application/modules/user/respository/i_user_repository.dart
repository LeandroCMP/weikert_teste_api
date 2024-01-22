import 'package:weikert_teste_api/models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> login(String user);
}
