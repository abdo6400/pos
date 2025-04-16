import 'package:dartz/dartz.dart';
import 'package:retail/features/sales/domain/entities/return_invoice.dart';
import 'package:retail/features/sales/domain/entities/return_invoice_detail.dart';

import '../../../../config/database/error/exceptions.dart';
import '../../../../config/database/error/failures.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/invoice_detail.dart';
import '../../domain/repositories/sales_repository.dart';
import '../datasources/sales_remote_data_source.dart';

class SalesRepositoryImpl extends SalesRepository {
  final SalesRemoteDataSource _salesRemoteDataSource;

  SalesRepositoryImpl({required SalesRemoteDataSource salesRemoteDataSource})
      : _salesRemoteDataSource = salesRemoteDataSource;

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

  @override
  Future<Either<Failure, void>> returnInvoice(Map<String, dynamic> data) async {
    try {
      final result = await _salesRemoteDataSource.returnInvoice(data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReturnInvoice>>> getReturnedInvoices(
      {required String branchId, required int userId}) async {
    try {
      final result = await _salesRemoteDataSource.getReturnedInvoices(
          branchId: branchId, userId: userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReturnInvoiceDetail>> getReturnedInvoicesDetail(
      {required int returnId, required String branchId}) async {
    try {
      final result = await _salesRemoteDataSource.getReturnedInvoicesDetail(
          returnId: returnId, branchId: branchId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
