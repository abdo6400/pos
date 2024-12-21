import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/auth_tokens_model.dart';
import '../models/otp_secret_model.dart';

abstract class RegisterRemoteDataSource {
  Future<AuthTokensModel> register(
      {required String email,
      required String password,
      required String userName,
      required String phoneNumber});
  Future<OtpSecretModel> checkEmail({required String email});
}

class RegisterRemoteDataSourceImpl
    implements RegisterRemoteDataSource {
  final ApiConsumer _apiConsumer;

  RegisterRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;
  @override
  Future<AuthTokensModel> register(
      {required String email,
      required String password,
      required String userName,
      required String phoneNumber}) async {
    final response = await _apiConsumer.post(EndPoints.register, body: {
      ApiKeys.email: email,
      ApiKeys.password: password,
      ApiKeys.userName: userName,
      ApiKeys.phone: phoneNumber
    });
    return AuthTokensModel.fromJson(response);
  }

  @override
  Future<OtpSecretModel> checkEmail({required String email}) async {
    final response = await _apiConsumer
        .post(EndPoints.checkEmail, body: {ApiKeys.email: email});

    return OtpSecretModel.fromJson(response);
  }

}
