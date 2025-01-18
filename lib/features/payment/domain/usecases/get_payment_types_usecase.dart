import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/payment_type.dart';
import '../repositories/payment_repository.dart';

class GetPaymentTypesUsecase
    extends UseCase<Either<Failure, List<PaymentType>>, NoParams> {
  final PaymentRepository _paymentRepository;

  GetPaymentTypesUsecase(this._paymentRepository);
  @override
  Future<Either<Failure, List<PaymentType>>> call(NoParams params) {
    return _paymentRepository.getPaymentType();
  }
}
