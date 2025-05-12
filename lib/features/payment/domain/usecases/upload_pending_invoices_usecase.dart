import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/payment_repository.dart';

class UploadPendingInvoicesUsecase
    extends UseCase<Either<Failure, bool>, UploadPendingInvoicesParams> {
  final PaymentRepository _paymentRepository;

  UploadPendingInvoicesUsecase(this._paymentRepository);
  @override
  Future<Either<Failure, bool>> call(params) async {
    final result = await _paymentRepository.uploadPendingInvoices(
      params.branchId,
      params.userNo,
    );
    return result;
  }
}

class UploadPendingInvoicesParams {
  final int branchId;
  final int userNo;

  UploadPendingInvoicesParams({
    required this.branchId,
    required this.userNo,
  });
}
