import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:weikert_teste_api/application/exceptions/request_validation_exception.dart';
import 'package:weikert_teste_api/application/exceptions/user_notfound_exception.dart';
import 'package:weikert_teste_api/application/helpers/jwt_helper.dart';
import 'package:weikert_teste_api/application/logger/i_logger.dart';
import 'package:weikert_teste_api/application/modules/user/service/i_user_service.dart';
import 'package:weikert_teste_api/application/modules/user/view_models/auth_view_model.dart';
import 'package:weikert_teste_api/models/user_logged_model.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController {
  final IUserService _userService;
  final ILogger _log;
  AuthController({
    required IUserService userService,
    required ILogger iLogger,
  })  : _userService = userService,
        _log = iLogger;

  @Route.post('/')
  Future<Response> login(Request request) async {
    try {
      final loginViewModel = AuthViewModel(await request.readAsString());
      final result = await _userService.login(loginViewModel.user!);
      if (result.user == loginViewModel.user &&
          result.password == loginViewModel.password) {
        return Response.ok(
          jsonEncode(
            UserLoggedModel(
              user: result,
              token: JwtHelper.generateJWT(result.id!),
            ).toMap(),
          ),
        );
      }
      throw UserNotfoundException(message: 'Usuário ou senha inválidos!');
    } on UserNotfoundException catch (e) {
      return Response.forbidden(
        jsonEncode({'message': e.message}),
      );
    } on RequestValidationException catch (e, s) {
      _log.error('Erro de parametros obrigatorios não enviados', e, s);
      return Response(400, body: jsonEncode(e.errors));
    } catch (e, s) {
      _log.error('Erro ao fazer login', e, s);
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro ao realizar login'}),
      );
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
