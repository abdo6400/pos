import 'package:equatable/equatable.dart';

abstract class DeliveryDiscount extends Equatable {
  final int lineId;
  final int companyId;
  final String companyDesc;
  final DateTime fromDate;
  final DateTime toDate;
  final double discountValue;
  final int branchId;
  final String branche;
  final bool isActive;

  DeliveryDiscount({
    required this.lineId,
    required this.companyId,
    required this.companyDesc,
    required this.fromDate,
    required this.toDate,
    required this.discountValue,
    required this.branchId,
    required this.branche,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        lineId,
        companyId,
        companyDesc,
        fromDate,
        toDate,
        discountValue,
        branchId,
        branche,
        isActive,
      ];
}
