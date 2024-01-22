import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:weikert_teste_api/application/config/application_config.dart';
import 'package:weikert_teste_api/application/middlewares/cors/cors_middlewares.dart';
import 'package:weikert_teste_api/application/middlewares/defaultContentType/default_content_type.dart';
import 'package:weikert_teste_api/application/middlewares/security/security_middleware.dart';

Future<void> main(List<String> arguments) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = '0.0.0.0';

  //ApplicationConfig
  final router = Router();
  final appConfig = ApplicationConfig();
  appConfig.loadConfigApplication(router);

  // Configure a pipeline that logs requests.
  final getIt = GetIt.I;
  getIt.registerSingleton(appConfig);
  final handler = const Pipeline()
      .addMiddleware(CorsMiddlewares().handler)
      .addMiddleware(
        DefaultContentType('application/json;charset=utf-8').handler,
      )
      .addMiddleware(SecurityMiddleware().handler)
      .addMiddleware(logRequests())
      .addHandler(router);
  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
