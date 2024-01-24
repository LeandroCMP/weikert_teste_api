import 'package:injectable/injectable.dart';
import 'package:weikert_teste_api/application/modules/student/service/i_student_service.dart';
import 'package:weikert_teste_api/models/client_model.dart';

@LazySingleton(as: IStudentService)
class StudentService implements IStudentService {
  final IStudentService _studentRepository;

  StudentService({required IStudentService studentRepository})
      : _studentRepository = studentRepository;
  @override
  Future<ClientModel?> registerStudent({
    required ClientModel student,
    required String idGroup,
  }) async =>
      await _studentRepository.registerStudent(
          student: student, idGroup: idGroup);

  @override
  Future<Exception?> deleteStudent({
    required String id,
    required String idGroup,
  }) async =>
      await _studentRepository.deleteStudent(id: id, idGroup: idGroup);

  @override
  Future<Exception?> updateStudent({
    required ClientModel student,
    required String idGroup,
  }) async =>
      await _studentRepository.updateStudent(
          student: student, idGroup: idGroup);

  @override
  Future<List<ClientModel>> getStudents({required String idGroup}) async =>
      await _studentRepository.getStudents(idGroup: idGroup);
}
