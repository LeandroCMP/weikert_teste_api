import 'package:shelf_router/shelf_router.dart';
import 'package:weikert_teste_api/application/routers/i_router.dart';

class RouterConfigure {
  final Router _router;
  final List<IRouter> _routers = [];

  RouterConfigure(this._router);

  // ignore: avoid_function_literals_in_foreach_calls
  void configure() => _routers.forEach((r) => r.configure(_router));
}
