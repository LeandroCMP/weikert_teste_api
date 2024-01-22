// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';
import 'package:weikert_teste_api/application/modules/user/respository/i_user_repository.dart';
import 'package:weikert_teste_api/application/modules/user/service/i_user_service.dart';
import 'package:weikert_teste_api/models/user_model.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  final IUserRepository _userRepository;
  UserService({
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<UserModel> login(String user) async =>
      await _userRepository.login(user);
}
