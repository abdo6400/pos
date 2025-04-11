import '../entities/settings.dart';

class SettingsModel extends Settings {
  SettingsModel(
      {required super.stationName,
      required super.printerId,
      required super.printerCashIp,
      required super.printerKitchenIp1,
      required super.printerKitchenIp2,
      required super.printerKitchenIp3,
      required super.printerKitchenIp4});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
        stationName: json['stationName'] as String,
        printerId: json['printerId'],
        printerCashIp: json['printerCashIp'] as String,
        printerKitchenIp1: json['printerKitchenIp1'] as String,
        printerKitchenIp2: json['printerKitchenIp2'] as String,
        printerKitchenIp3: json['printerKitchenIp3'] as String,
        printerKitchenIp4: json['printerKitchenIp4'] as String);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'stationName': stationName,
      'printerId': printerId,
      'printerCashIp': printerCashIp,
      'printerKitchenIp1': printerKitchenIp1,
      'printerKitchenIp2': printerKitchenIp2,
      'printerKitchenIp3': printerKitchenIp3,
      'printerKitchenIp4': printerKitchenIp4
    };
  }
}
