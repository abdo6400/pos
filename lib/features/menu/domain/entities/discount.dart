import 'package:equatable/equatable.dart';

abstract class Discount extends Equatable {
  final int serial;
  final double discountPercentage;
  final String discountTypeAr;
  final String discountTypeEn;
  final bool active;

  Discount({
    required this.serial,
    required this.discountPercentage,
    required this.discountTypeAr,
    required this.discountTypeEn,
    required this.active,
  });

  @override
  List<Object> get props =>
      [serial, discountPercentage, discountTypeAr, discountTypeEn, active];
}
