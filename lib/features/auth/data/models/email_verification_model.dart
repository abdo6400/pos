import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/email_verification.dart';

class EmailVerificationModel extends EmailVerification {
  const EmailVerificationModel({required super.isVerified});

  factory EmailVerificationModel.fromJson(Map<String, dynamic> json) {
    return EmailVerificationModel(isVerified: json[ApiKeys.isVerified]);
  }
}
