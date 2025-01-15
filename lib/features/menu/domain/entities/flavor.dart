import 'package:equatable/equatable.dart';

abstract class Flavor extends Equatable {
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

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [
        flavorNo,
        flavorAr,
        flavorEn,
        price,
        warehouse,
        category,
        isActive,
      ];
}
