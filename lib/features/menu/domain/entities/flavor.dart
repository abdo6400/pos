abstract class Flavor {
  final int flavorNo;
  final String flavorAr;
  final String flavorEn;
  final double price;
  final String warehouse;
  final List<String> category;
  final bool isActive;

  Flavor({
    required this.flavorNo,
    required this.flavorAr,
    required this.flavorEn,
    required this.price,
    required this.warehouse,
    required this.category,
    required this.isActive,
  });
}
