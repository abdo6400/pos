import 'package:equatable/equatable.dart';

abstract class Delivery extends Equatable {
  final int companyId;
  final String companyName;
  final String? phone;
  final String? email;
  final double percent;
  final int priceCategory;
  final bool active;

  Delivery({
    required this.companyId,
    required this.companyName,
    required this.phone,
    required this.email,
    required this.percent,
    required this.priceCategory,
    required this.active,
  });

  @override
  List<Object?> get props => [
        companyId,
        companyName,
        phone,
        email,
        percent,
        priceCategory,
        active,
      ];
}
