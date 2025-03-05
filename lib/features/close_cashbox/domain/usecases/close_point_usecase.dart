import 'package:dartz/dartz.dart';

import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/close_point_repository.dart';

class ClosePointUsecase
    extends UseCase<Either<Failure, void>, ClosePointParams> {
  final ClosePointRepository _repository;

  ClosePointUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(ClosePointParams params) {
    return _repository.closePoint(params.toJson());
  }
}

class ClosePointParams {
  final String cashNo;
  final int cashUser;
  final DateTime cashRealEndTime;
  final double cashWithDrawals;
  final double cashSubTotal;
  final double cashDiscountTotal;
  final double cashTaxTotal;
  final double cashServiceTotal;
  final double cashGrandTotal;
  final double requiredCash;
  final double availableCash;
  final double cashCustomerPayment;
  final double voidAfter;
  final double voidBefore;
  final double illegalOpenCashDrawer;

  ClosePointParams(
      {required this.cashNo,
      required this.cashUser,
      required this.cashRealEndTime,
      required this.cashWithDrawals,
      required this.cashSubTotal,
      required this.cashDiscountTotal,
      required this.cashTaxTotal,
      required this.cashServiceTotal,
      required this.cashGrandTotal,
      required this.requiredCash,
      required this.availableCash,
      required this.cashCustomerPayment,
      required this.voidAfter,
      required this.voidBefore,
      required this.illegalOpenCashDrawer});

  Map<String, dynamic> toJson() => {
        ApiKeys.cashNo: cashNo,
        ApiKeys.cashUser: cashUser,
        ApiKeys.cashRealEndTime: cashRealEndTime.toIso8601String(),
        ApiKeys.cashWithDrawals: cashWithDrawals,
        ApiKeys.cashSubTotal: cashSubTotal,
        ApiKeys.cashDiscountTotal: cashDiscountTotal,
        ApiKeys.cashTaxTotal: cashTaxTotal,
        ApiKeys.cashServiceTotal: cashServiceTotal,
        ApiKeys.cashGrandTotal: cashGrandTotal,
        ApiKeys.requiredCash: requiredCash,
        ApiKeys.availableCash: availableCash,
        ApiKeys.cashCustomerPayment: cashCustomerPayment,
        ApiKeys.voidAfter: voidAfter,
        ApiKeys.voidBefore: voidBefore,
        ApiKeys.illegalOpenCashDrawer: illegalOpenCashDrawer,
      };
}
