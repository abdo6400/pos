import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../../../../core/models/auth_tokens_model.dart';

abstract class LoginRemoteDataSource {
  Future<AuthTokensModel> login(
      {required String email, required String password});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiConsumer _apiConsumer;

  LoginRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;
  @override
  Future<AuthTokensModel> login(
      {required String email, required String password}) async {
    final response = await _apiConsumer.post(EndPoints.login,
        queryParameters: {ApiKeys.userName: email, ApiKeys.password: password});
    return AuthTokensModel.fromJson(response[EndPoints.response]);
  }
}
