import 'dart:convert';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';
import 'package:weikert_teste_api/application/helpers/jwt_helper.dart';
import 'package:weikert_teste_api/application/logger/i_logger.dart';
import 'package:weikert_teste_api/application/logger/logger.dart';
import 'package:weikert_teste_api/application/middlewares/middlewares.dart';
import 'package:weikert_teste_api/application/middlewares/security/security_skip_url.dart';

class SecurityMiddleware extends Middlewares {
  ILogger iLogger = Logger();
  final skypUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/auth/', method: 'POST'),
  ];

  SecurityMiddleware();

  @override
  Future<Response> execute(Request request) async {
    try {
      if (skypUrl.contains(SecuritySkipUrl(
          url: '/${request.url.path}', method: request.method))) {
        return innerHandler(request);
      }

      final authHeader = request.headers['Authorization'];

      if (authHeader == null || authHeader.isEmpty) {
        throw JwtException.invalidToken;
      }

      final authHeaderContent = authHeader.split(' ');

      if (authHeaderContent[0] != 'Bearer') {
        throw JwtException.invalidToken;
      }

      final authorizationToken = authHeaderContent[1];
      final claims = JwtHelper.getClaims(authorizationToken);

      if (request.url.path != 'auth/refresh') {
        claims.validate();
      }

      final claimsMap = claims.toJson();

      final userId = claimsMap['sub'];

      if (userId == null) {
        throw JwtException.invalidToken;
      }

      final securityHeaders = {
        'user': userId,
        'access_token': authorizationToken,
      };

      return innerHandler(request.change(headers: securityHeaders));
    } on JwtException catch (e, s) {
      iLogger.error('Erro ao validar token JWT', e, s);
      return Response.forbidden(
        jsonEncode({"message": "Erro ao validar token JWT"}),
      );
    } catch (e, s) {
      iLogger.error('Internal Server Error', e, s);
      return Response.forbidden(
        jsonEncode({"message": "Internal Server Error"}),
      );
    }
  }
}
