import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/password_changed.dart';

class PasswordChangedModel extends PasswordChange {
  const PasswordChangedModel({required super.isChanged});

  factory PasswordChangedModel.fromJson(Map<String, dynamic> json) {
    return PasswordChangedModel(isChanged: json[ApiKeys.isChanged]);
  }
}
