import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../entities/setting.dart';

abstract class SettingsRepository {
  Future<Either<Failure, List<Setting>>> getSettings(String branchId);
}
