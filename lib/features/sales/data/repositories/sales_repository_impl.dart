import 'package:dartz/dartz.dart';

import '../../../../config/database/error/exceptions.dart';
import '../../../../config/database/error/failures.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/invoice_detail.dart';
import '../../domain/repositories/sales_repository.dart';
import '../datasources/sales_remote_data_source.dart';

class SalesRepositoryImpl extends SalesRepository {
  final SalesRemoteDataSource _salesRemoteDataSource;

  SalesRepositoryImpl(this._salesRemoteDataSource);
  @override
  Future<Either<Failure, List<Invoice>>> getInvoices(
      {required String branchId,
      required String startDate,
      required String endDate,
      required String userId}) async {
    try {
      final result = await _salesRemoteDataSource.getInvoices(
          branchId: branchId,
          startDate: startDate,
          endDate: endDate,
          userId: userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceDetail>> getInvoiceDetail(
      {required String invoiceNo}) async {
    try {
      final result =
          await _salesRemoteDataSource.getInvoicesDetail(invoiceNo: invoiceNo);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
