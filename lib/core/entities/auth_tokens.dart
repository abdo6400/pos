import '../../config/database/api/api_keys.dart';
import 'persmission.dart';

abstract class AuthTokens {
  final String token;
  final int userNo;
  final String username;
  final bool takeAway;
  final bool driveThru;
  final bool dineInopen;
  final bool dineInclose;
  final String defaultBranch;
  final String defaultCurrency;
  final int numbersOfDigits;
  final String taxNo;
  final String branchName;
  final String phones;
  final String address;
  final String poBox;
  final String website;
  final DateTime expaireDate;
  final List<Permission> permissions;

  AuthTokens({
    required this.token,
    required this.userNo,
    required this.username,
    required this.takeAway,
    required this.driveThru,
    required this.dineInopen,
    required this.dineInclose,
    required this.defaultBranch,
    required this.defaultCurrency,
    required this.numbersOfDigits,
    required this.taxNo,
    required this.branchName,
    required this.phones,
    required this.address,
    required this.poBox,
    required this.website,
    required this.expaireDate,
    required this.permissions,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.token: token,
      ApiKeys.userNo: userNo,
      ApiKeys.username: username,
      ApiKeys.takeAway: takeAway,
      ApiKeys.driveThru: driveThru,
      ApiKeys.dineInopen: dineInopen,
      ApiKeys.dineInclose: dineInclose,
      ApiKeys.defaultBranch: defaultBranch,
      ApiKeys.defaultCurrency: defaultCurrency,
      ApiKeys.numbersOfDigits: numbersOfDigits,
      ApiKeys.taxNo: taxNo,
      ApiKeys.branchName: branchName,
      ApiKeys.phones: phones,
      ApiKeys.address: address,
      ApiKeys.poBox: poBox,
      ApiKeys.website: website,
      ApiKeys.expaireDate: expaireDate.toIso8601String(),
      ApiKeys.permissions:
          List<dynamic>.from(permissions.map((x) => x.toJson())),
    };
  }
}
