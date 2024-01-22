// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:weikert_teste_api/application/database/i_database_connection.dart';
import 'package:weikert_teste_api/application/exceptions/database_exception.dart';
import 'package:weikert_teste_api/application/exceptions/user_notfound_exception.dart';
import 'package:weikert_teste_api/application/logger/i_logger.dart';
import 'package:weikert_teste_api/application/modules/user/respository/i_user_repository.dart';
import 'package:weikert_teste_api/models/user_model.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatabaseConnection _connection;
  final ILogger _log;
  Db? conn;
  UserRepository({
    required IDatabaseConnection connection,
    required ILogger log,
  })  : _connection = connection,
        _log = log;

  @override
  Future<UserModel> login(String user) async {
    try {
      conn = await _connection.openConnection();
      await conn!.open();
      final collection = conn!.collection('users');
      final result = await collection.modernFindOne(filter: {"user": user});
      if (result != null) {
        result['_id'] = result['_id'].$oid;
        return UserModel.fromMap(result);
      } else {
        throw UserNotfoundException(message: 'Usuário não encontrado!');
      }
    } on MongoDartError catch (e, s) {
      _log.error('Erro ao buscar usuario!', e, s);
      return throw DatabaseException(message: 'Erro ao buscar usuario');
    } on UserNotfoundException catch (e) {
      _log.error(e.message);
      return throw UserNotfoundException(message: e.message);
    }
  }
}
