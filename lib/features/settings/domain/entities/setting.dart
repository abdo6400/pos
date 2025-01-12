import 'package:equatable/equatable.dart';

abstract class Setting extends Equatable {
  final int settingId;
  final String settingArdesc;
  final String settingEndesc;
  final String value1;
  final double value2;
  final double value3;
  final bool value4;
  final DateTime value5;
  final bool visible;
  final String groupTypeAr;
  final String groupTypeEn;

  Setting({
    required this.settingId,
    required this.settingArdesc,
    required this.settingEndesc,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.visible,
    required this.groupTypeAr,
    required this.groupTypeEn,
  });

  @override
  List<Object?> get props => [
        settingId,
        settingArdesc,
        settingEndesc,
        value1,
        value2,
        value3,
        value4,
        value5,
        visible,
        groupTypeAr,
        groupTypeEn
      ];
}
