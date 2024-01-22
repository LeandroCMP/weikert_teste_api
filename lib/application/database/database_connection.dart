import 'package:injectable/injectable.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:weikert_teste_api/application/config/database_connection_configuration.dart';

import './i_database_connection.dart';

@LazySingleton(as: IDatabaseConnection)
class DatabaseConnection implements IDatabaseConnection {
  final DatabaseConnectionConfiguration _configuration;

  DatabaseConnection(this._configuration);

  @override
  Future<Db> openConnection() async {
    Db db = Db(
        "${_configuration.host}:${_configuration.port}/${_configuration.databaseName}");
    return db;
  }
}
