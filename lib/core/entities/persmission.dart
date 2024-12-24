import 'package:equatable/equatable.dart';

import '../../config/database/api/api_keys.dart';

class Permission extends Equatable {
  final int userNo;
  final String permissionId;
  final bool allow;
  final int warehouseId;

  Permission({
    required this.userNo,
    required this.permissionId,
    required this.allow,
    required this.warehouseId,
  });
  Map<String, dynamic> toJson() {
    return {
      ApiKeys.userNo: userNo,
      ApiKeys.permissionId: permissionId,
      ApiKeys.allow: allow,
      ApiKeys.warehouseId: warehouseId,
    };
  }

  @override
  List<Object?> get props => [userNo, permissionId, allow, warehouseId];
}
