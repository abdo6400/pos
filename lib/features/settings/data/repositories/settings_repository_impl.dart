import 'package:dartz/dartz.dart';

import 'package:retail/config/database/error/failures.dart';

import 'package:retail/features/settings/domain/entities/setting.dart';

import '../../../../config/database/error/exceptions.dart';
import '../../../../core/entities/cash.dart';
import '../../../../core/entities/sale_date.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource _settingsRemoteDataSource;

  SettingsRepositoryImpl(
      {required SettingsRemoteDataSource settingsRemoteDataSource})
      : _settingsRemoteDataSource = settingsRemoteDataSource;

  @override
  Future<Either<Failure, List<Setting>>> getSettings(String branchId) async {
    try {
      final response = await _settingsRemoteDataSource.getSettings(branchId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SaleDate>>> getSalesByWarehouse(
      String branchId) async {
    try {
      final response =
          await _settingsRemoteDataSource.getSalesByWarehouse(branchId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cash>> getSalesByUser(int userId) async {
    try {
      final response = await _settingsRemoteDataSource.getSalesByUser(userId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> endDay(Map<String, dynamic> data) async {
    try {
      await _settingsRemoteDataSource.endDay(data);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> openPointByParameters(
      Map<String, dynamic> data) async {
    try {
      await _settingsRemoteDataSource.openPointByParameters(data);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
