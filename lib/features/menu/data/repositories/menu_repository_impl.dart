import 'package:dartz/dartz.dart';
import 'package:retail/features/menu/domain/entities/product.dart';
import '../../../../config/database/error/exceptions.dart';
import '../../../../config/database/error/failures.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_remote_data_source.dart';

class MenuRepositoryImpl extends MenuRepository {
  final MenuRemoteDataSource _menuRemoteDataSource;

  MenuRepositoryImpl({required MenuRemoteDataSource menuRemoteDataSource})
      : _menuRemoteDataSource = menuRemoteDataSource;
  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      return Right(await _menuRemoteDataSource.getCategories());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts(String branchId) async {
    try {
      return Right(await _menuRemoteDataSource.getProducts(branchId));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
