import 'package:weikert_teste_api/models/client_model.dart';

abstract class IStudentRepository {
  Future<ClientModel?> registerStudent({
    required ClientModel student,
    required String idGroup,
  });

  Future<Exception?> updateStudent({
    required ClientModel student,
    required String idGroup,
  });

  Future<Exception?> deleteStudent({
    required String id,
    required String idGroup,
  });

  Future<List<ClientModel>> getStudents({
    required String idGroup,
  });
}
