import '../../config/database/api/api_keys.dart';
import '../entities/auth_tokens.dart';
import 'permission_model.dart';

class AuthTokensModel extends AuthTokens {
  AuthTokensModel(
      {required super.token,
      required super.userNo,
      required super.username,
      required super.takeAway,
      required super.driveThru,
      required super.dineInopen,
      required super.dineInclose,
      required super.defaultBranch,
      required super.defaultCurrency,
      required super.numbersOfDigits,
      required super.taxNo,
      required super.branchName,
      required super.phones,
      required super.address,
      required super.poBox,
      required super.website,
      required super.expaireDate,
      required super.permissions});

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) {
    return AuthTokensModel(
      token: json[ApiKeys.token],
      userNo: json[ApiKeys.userNo],
      username: json[ApiKeys.username],
      takeAway: json[ApiKeys.takeAway],
      driveThru: json[ApiKeys.driveThru],
      dineInopen: json[ApiKeys.dineInopen],
      dineInclose: json[ApiKeys.dineInclose],
      defaultBranch: json[ApiKeys.defaultBranch],
      defaultCurrency: json[ApiKeys.defaultCurrency],
      numbersOfDigits: json[ApiKeys.numbersOfDigits],
      taxNo: json[ApiKeys.taxNo],
      branchName: json[ApiKeys.branchName],
      phones: json[ApiKeys.phones],
      address: json[ApiKeys.address],
      poBox: json[ApiKeys.poBox],
      website: json[ApiKeys.website],
      expaireDate: DateTime.parse(json[ApiKeys.expaireDate]),
      permissions: List<PermissionModel>.from(
          json[ApiKeys.permissions].map((x) => PermissionModel.fromJson(x))),
    );
  }
}
