import 'package:injectable/injectable.dart';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:weikert_teste_api/application/database/i_database_connection.dart';
import 'package:weikert_teste_api/application/exceptions/student_failure.dart';
import 'package:weikert_teste_api/application/logger/i_logger.dart';
import 'package:weikert_teste_api/application/modules/student/repository/i_student_repository.dart';
import 'package:weikert_teste_api/models/client_model.dart';
import 'package:weikert_teste_api/models/subjects_model.dart';

@LazySingleton(as: IStudentRepository)
class StudentRepository implements IStudentRepository {
  final IDatabaseConnection _connection;
  final ILogger _log;
  Db? conn;
  StudentRepository({
    required IDatabaseConnection connection,
    required ILogger log,
  })  : _connection = connection,
        _log = log;
  @override
  Future<ClientModel?> registerStudent({
    required ClientModel student,
    required String idGroup,
  }) async {
    try {
      conn = await _connection.openConnection();
      await conn!.open();
      conn?.databaseName = idGroup;
      final collection = conn!.collection('students');
      final result = await collection.insertOne(student.toMap());

      if (result.isFailure) {
        throw MongoDartError(
          "Ocorreu um erro!",
          errorCode: 'Ocorreu um erro ao cadastrar o arrendamento!',
        );
      } else {
        final studentResult = result.document!.map(
          (key, value) => MapEntry(key, value),
        );

        final id = studentResult['_id'] as ObjectId;

        final subjectsResult = studentResult['animals'] as List<Map>;

        subjectsResult.map((e) {
          return e.map((key, value) => MapEntry(key, value));
        }).toList();

        final subjects = <SubjectsModel>[];
        for (var value in subjectsResult) {
          final subject = SubjectsModel(
            id: value['_id'].$oid,
            subject: value['subject'],
          );
          subjects.add(subject);
        }

        return ClientModel(
          id: id.$oid,
          name: studentResult['name'] as String,
          phone: studentResult['phone'] as String,
          subjects: subjects,
        );
      }
    } on MongoDartError catch (e) {
      _log.error(e);
      _log.error(e.errorCode);
      return throw Exception();
    }
  }

  @override
  Future<Exception?> deleteStudent({
    required String id,
    required String idGroup,
  }) async {
    try {
      conn = await _connection.openConnection();
      await conn!.open();
      conn?.databaseName = idGroup;
      final collection = conn!.collection('students');
      final result = await collection.deleteOne(
        where.eq('_id', ObjectId.fromHexString(id)),
      );
      if (result.isFailure) {
        throw MongoDartError(
          "Ocorreu um erro!",
          errorCode: result.writeError?.code.toString(),
        );
      }
      return null;
    } on MongoDartError catch (e) {
      _log.error(e);
      _log.error(e.errorCode);
      return throw Exception();
    }
  }

  @override
  Future<Exception?> updateStudent({
    required ClientModel student,
    required String idGroup,
  }) async {
    try {
      conn = await _connection.openConnection();
      await conn!.open();
      conn?.databaseName = idGroup;
      final collection = conn!.collection('students');
      final studentResult = student.toMap();
      studentResult.remove('_id');
      final result = await collection.updateOne(
        where.eq('_id', ObjectId.fromHexString(student.id!)),
        {r'$set': studentResult},
      );
      if (result.isFailure) {
        _log.error(result.writeError?.errmsg);
        throw MongoDartError(
          "Ocorreu um erro!",
          errorCode: result.writeError?.code.toString(),
        );
      }
      return null;
    } on MongoDartError catch (e) {
      _log.error(e);
      _log.error(e.errorCode);
      return throw Exception();
    }
  }

  @override
  Future<List<ClientModel>> getStudents({required String idGroup}) async {
    try {
      conn = await _connection.openConnection();
      await conn!.open();
      conn?.databaseName = idGroup;
      final collection = conn!.collection('students');
      final result = await collection.find().toList();
      if (result.isNotEmpty) {
        return result.map((student) {
          return ClientModel(
            id: student['_id'].$oid,
            name: student['name'],
            phone: student['phone'],
            subjects: List<SubjectsModel>.from(
              student['subjects'].map<SubjectsModel>(
                (sub) => SubjectsModel(
                  id: sub['id'],
                  subject: sub['subject'],
                ),
              ),
            ).toList(),
          );
        }).toList();
      } else {
        throw StudentsNotFoundFailure();
      }
    } on StudentsNotFoundFailure catch (e) {
      _log.error(e);
      return throw StudentsNotFoundFailure();
    } on MongoDartError catch (e) {
      _log.error(e);
      return throw Exception();
    }
  }
}
