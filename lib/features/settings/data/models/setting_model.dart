import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/setting.dart';

class SettingModel extends Setting {
  SettingModel(
      {required super.settingId,
      required super.settingArdesc,
      required super.settingEndesc,
      required super.value1,
      required super.value2,
      required super.value3,
      required super.value4,
      required super.value5,
      required super.visible,
      required super.groupTypeAr,
      required super.groupTypeEn});

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        settingId: json[ApiKeys.settingId],
        settingArdesc: json[ApiKeys.settingArdesc],
        settingEndesc: json[ApiKeys.settingEndesc],
        value1: json[ApiKeys.value1],
        value2: double.tryParse(json[ApiKeys.value2].toString()) ?? 0.0,
        value3: double.tryParse(json[ApiKeys.value3].toString()) ?? 0.0,
        value4: json[ApiKeys.value4],
        value5: DateTime.parse(json[ApiKeys.value5]),
        visible: json[ApiKeys.visible],
        groupTypeAr: json[ApiKeys.groupTypeAr],
        groupTypeEn: json[ApiKeys.groupTypeEn],
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.settingId: settingId,
        ApiKeys.settingArdesc: settingArdesc,
        ApiKeys.settingEndesc: settingEndesc,
        ApiKeys.value1: value1,
        ApiKeys.value2: value2,
        ApiKeys.value3: value3,
        ApiKeys.value4: value4,
        ApiKeys.value5: value5.toIso8601String(),
        ApiKeys.visible: visible,
        ApiKeys.groupTypeAr: groupTypeAr,
        ApiKeys.groupTypeEn: groupTypeEn,
      };
}
