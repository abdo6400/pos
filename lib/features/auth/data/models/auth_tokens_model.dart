import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/auth_tokens.dart';

class AuthTokensModel extends AuthTokens {
  const AuthTokensModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) =>
      AuthTokensModel(
        accessToken: json[ApiKeys.accessToken],
        refreshToken: json[ApiKeys.refreshToken],
      );
}

