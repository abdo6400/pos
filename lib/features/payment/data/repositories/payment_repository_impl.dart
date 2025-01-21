import 'package:dartz/dartz.dart';

import 'package:retail/config/database/error/failures.dart';
import 'package:retail/features/payment/domain/entities/cash.dart';

import 'package:retail/features/payment/domain/entities/payment_type.dart';
import 'package:retail/features/payment/domain/entities/sale_date.dart';

import '../../../../config/database/network/netwok_info.dart';
import '../../domain/entities/invoice_id.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_local_data_source.dart';
import '../datasources/payment_remote_data_source.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentRemoteDataSource _paymentRemoteDataSource;
  final PaymentLocalDataSource _paymentLocalDataSource;
  final NetworkInfo _networkInfo;
  PaymentRepositoryImpl(
      {required PaymentRemoteDataSource paymentRemoteDataSource,
      required PaymentLocalDataSource paymentLocalDataSource,
      required NetworkInfo networkInfo})
      : _paymentRemoteDataSource = paymentRemoteDataSource,
        _paymentLocalDataSource = paymentLocalDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<PaymentType>>> getPaymentType() async {
    return await _networkInfo.handleNetworkRequest<List<PaymentType>>(
        remoteRequest: _paymentRemoteDataSource.getPaymentTypes,
        cacheData: _paymentLocalDataSource.insertPaymentTypes,
        localRequest: _paymentLocalDataSource.getPaymentTypes);
  }

  @override
  Future<Either<Failure, void>> pay(Map<String, dynamic> data) {
    return _networkInfo.handleNetworkPendingRequest(
      remoteRequest: () => _paymentRemoteDataSource.pay(data),
      localRequest: () async => _paymentLocalDataSource.pay(data),
    );
  }

  @override
  Future<Either<Failure, InvoiceId>> getLastInvoiceId(int branchId) async {
    try {
      final response =
          await _paymentRemoteDataSource.getLastInvoiceId(branchId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cash>> getCash(int userNo) async {
    try {
      final response = await _paymentRemoteDataSource.getCash(userNo);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SaleDate>> getSaleDate(int branchId) async {
    try {
      final response = await _paymentRemoteDataSource.getSaleDate(branchId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
