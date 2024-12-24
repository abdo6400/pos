import '../../config/database/api/api_keys.dart';
import '../entities/persmission.dart';

class PermissionModel extends Permission {
  PermissionModel(
      {required super.userNo,
      required super.permissionId,
      required super.allow,
      required super.warehouseId});

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      userNo: json[ApiKeys.userNo],
      permissionId: json[ApiKeys.permissionId],
      allow: json[ApiKeys.allow],
      warehouseId: json[ApiKeys.warehouseId],
    );
  }
}
