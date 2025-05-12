import 'package:dartz/dartz.dart';

import 'package:retail/config/database/error/failures.dart';
import 'package:retail/core/entities/cash.dart';

import 'package:retail/features/payment/domain/entities/payment_type.dart';
import 'package:retail/core/entities/sale_date.dart';

import '../../../../config/database/network/netwok_info.dart';
import '../../domain/entities/invoice.dart';
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
  Future<Either<Failure, String>> pay(Map<String, dynamic> data) {
    return _networkInfo.handleNetworkPendingRequest(
      remoteRequest: () => _paymentRemoteDataSource.pay(data),
      localRequest: () => _paymentLocalDataSource.pay(data),
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

  @override
  Future<Either<Failure, bool>> uploadPendingInvoices(
      int branchId, int userNo) async {
    try {
      final response = await _paymentLocalDataSource.getPendingInvoices();
      final saleDate =
          (await getSaleDate(branchId)).fold((l) => null, (r) => r);
      final cash = (await getCash(userNo)).fold((l) => null, (r) => r);
      final invoiceId =
          (await getLastInvoiceId(branchId)).fold((l) => null, (r) => r);
      final saleDateTime =
          "${saleDate?.lineDate.year}-${saleDate?.lineDate.month}-${saleDate?.lineDate.day}";
      final double invoiceNo =
          double.tryParse(invoiceId?.invoiceNo ?? "0") ?? 0;
      double increamenter = 0;
      List<Invoice> invoices = response.map((e) {
        final newInvoiceNo = (invoiceNo) + increamenter;
        increamenter = increamenter + 1;
        return e.copyWith(
            invoiceNo: (newInvoiceNo).toString(),
            invoiceCashNo: cash?.cashNo,
            salesDate: saleDateTime);
      }).toList();
      if (invoices.isEmpty) {
        return Right(false);
      }
      for (var element in invoices) {
        await pay(element.toJson());
      }
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
