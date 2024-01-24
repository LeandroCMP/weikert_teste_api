import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:weikert_teste_api/application/modules/student/controller/student_controller.dart';
import 'package:weikert_teste_api/application/routers/i_router.dart';

class StudentRouter implements IRouter {
  @override
  void configure(Router router) {
    final studentController = GetIt.I.get<StudentController>();

    router.mount('/student/', studentController.router);
  }
}
