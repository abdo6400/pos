import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/otp_secret.dart';

class OtpSecretModel extends OtpSecret {
  const OtpSecretModel({
    required super.secret,
  });

  factory OtpSecretModel.fromJson(Map<String, dynamic> json) => OtpSecretModel(
        secret: json[ApiKeys.secret],
      );
}
