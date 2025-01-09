import 'package:dartz/dartz.dart';

import 'package:retail/config/database/error/failures.dart';

import 'package:retail/features/settings/domain/entities/setting.dart';

import '../../../../config/database/error/exceptions.dart';
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
    }
  }
}
