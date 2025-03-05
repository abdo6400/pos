import 'package:dartz/dartz.dart';
import 'package:retail/config/database/error/exceptions.dart';

import 'package:retail/config/database/error/failures.dart';
import 'package:retail/core/entities/cash.dart';

import 'package:retail/features/close_cashbox/domain/entities/cash_sale.dart';

import 'package:retail/features/close_cashbox/domain/entities/payment_summary.dart';

import 'package:retail/features/close_cashbox/domain/entities/sale_summary.dart';

import '../../domain/repositories/close_point_repository.dart';
import '../datasources/close_point_remote_data_source.dart';

class ClosePointRepositoryImpl extends ClosePointRepository {
  final ClosePointRemoteDataSource _closePointRemoteDataSource;

  ClosePointRepositoryImpl(
      {required ClosePointRemoteDataSource closePointRemoteDataSource})
      : _closePointRemoteDataSource = closePointRemoteDataSource;
  @override
  Future<Either<Failure, void>> closePoint(Map<String, dynamic> data) async {
    try {
      final result = await _closePointRemoteDataSource.closePoint(data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CashSale>> getCashSaleSummary(String cashNo) async {
    try {
      final result =
          await _closePointRemoteDataSource.getCashSaleSummary(cashNo);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PaymentSummary>>> getPaymentsSummary(
      String cashNo, String wareHouse) async {
    try {
      final result = await _closePointRemoteDataSource.getPaymentsSummary(
          cashNo, wareHouse);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SaleSummary>>> getSalesSummary(
      String cashNo) async {
    try {
      final result = await _closePointRemoteDataSource.getSalesSummary(cashNo);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cash>> getCash(int userNo) async {
    try {
      final result = await _closePointRemoteDataSource.getCash(userNo);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
