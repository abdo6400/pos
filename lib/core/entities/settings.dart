abstract class Settings {
  final String stationName;
  final int printerId;
  final String printerCashIp;
  final String printerKitchenIp1;
  final String printerKitchenIp2;
  final String printerKitchenIp3;
  final String printerKitchenIp4;

  Settings(
      {required this.stationName,
      required this.printerId,
      required this.printerCashIp,
      required this.printerKitchenIp1,
      required this.printerKitchenIp2,
      required this.printerKitchenIp3,
      required this.printerKitchenIp4});

   toJson();
  
  
}
