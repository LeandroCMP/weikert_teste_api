// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$StudentControllerRouter(StudentController service) {
  final router = Router();
  router.add(
    'GET',
    r'/',
    service.getStudents,
  );
  router.add(
    'POST',
    r'/register',
    service.registerStudent,
  );
  router.add(
    'POST',
    r'/delete',
    service.deleteStudent,
  );
  router.add(
    'POST',
    r'/update',
    service.updateStudent,
  );
  return router;
}
