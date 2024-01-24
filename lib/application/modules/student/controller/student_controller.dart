import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:weikert_teste_api/application/exceptions/student_failure.dart';
import 'package:weikert_teste_api/application/logger/i_logger.dart';
import 'package:weikert_teste_api/application/modules/student/service/i_student_service.dart';
import 'package:weikert_teste_api/application/modules/student/view_models/delete_student_view_model.dart';
import 'package:weikert_teste_api/application/modules/student/view_models/register_student_view_model.dart';
import 'package:weikert_teste_api/application/modules/student/view_models/update_student_view_model.dart';
import 'package:weikert_teste_api/models/client_model.dart';

part 'student_controller.g.dart';

@Injectable()
class StudentController {
  final IStudentService _studentService;
  final ILogger _log;

  StudentController({
    required IStudentService studentService,
    required ILogger iLogger,
  })  : _studentService = studentService,
        _log = iLogger;

  @Route.get('/')
  Future<Response> getStudents(Request request) async {
    try {
      final idGroup = request.headers['idGroup'];

      final result = await _studentService.getStudents(idGroup: idGroup!);

      return Response.ok(
        jsonEncode(result.map((e) => e.toMap()).toList()),
      );
    } catch (e) {
      _log.error(e);
      if (e is StudentsNotFoundFailure) return Response(403);
      return Response.internalServerError();
    }
  }

  @Route.post('/register')
  Future<Response> registerStudent(Request request) async {
    try {
      final idGroup = request.headers['idGroup'];

      final registerViewModel = RegisterStudentViewModel(
        await request.readAsString(),
      );
      final studentModel = ClientModel.fromMap(registerViewModel.data);

      final result = await _studentService.registerStudent(
          student: studentModel, idGroup: idGroup!);

      return Response.ok(
        jsonEncode({
          'message': 'Aluno cadastrado com sucesso!',
          'student': result!.toMap()
        }),
      );
    } on Exception catch (e) {
      _log.error(e);

      return Response.internalServerError();
    }
  }

  @Route.post('/delete')
  Future<Response> deleteStudent(Request request) async {
    try {
      final idGroup = request.headers['idGroup'];

      final deleteViewModel = DeleteStudentViewModel(
        await request.readAsString(),
      );
      await _studentService.deleteStudent(
        id: deleteViewModel.data['id'],
        idGroup: idGroup!,
      );

      return Response.ok(
        jsonEncode({'message': 'Arrendamento deletado com sucesso!'}),
      );
    } on Exception catch (e) {
      _log.error(e);
      return Response.internalServerError();
    }
  }

  @Route.post('/update')
  Future<Response> updateStudent(Request request) async {
    try {
      final idGroup = request.headers['idGroup'];

      final updateViewModel = UpdateStudentViewModel(
        await request.readAsString(),
      );
      ClientModel studentModel = ClientModel.fromMap(updateViewModel.data);
      print(studentModel);

      await _studentService.updateStudent(
          student: studentModel, idGroup: idGroup!);

      return Response.ok(
        jsonEncode({'message': 'Arrendamento deletado com sucesso!'}),
      );
    } on Exception catch (e) {
      _log.error(e);
      return Response.internalServerError();
    }
  }

  Router get router => _$StudentControllerRouter(this);
}
