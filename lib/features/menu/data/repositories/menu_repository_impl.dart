import 'package:dartz/dartz.dart';
import 'package:retail/features/menu/domain/entities/category.dart';
import 'package:retail/features/menu/domain/entities/flavor.dart';
import 'package:retail/features/menu/domain/entities/product.dart';
import 'package:retail/features/menu/domain/entities/question.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../config/database/network/netwok_info.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_local_data_source.dart';
import '../datasources/menu_remote_data_source.dart';

class MenuRepositoryImpl extends MenuRepository {
  final MenuRemoteDataSource _menuRemoteDataSource;
  final MenuLocalDataSource _menuLocalDataSource;
  final NetworkInfo _networkInfo;

  MenuRepositoryImpl({
    required MenuRemoteDataSource menuRemoteDataSource,
    required MenuLocalDataSource menuLocalDataSource,
    required NetworkInfo networkInfo,
  })  : _menuRemoteDataSource = menuRemoteDataSource,
        _menuLocalDataSource = menuLocalDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    return _networkInfo.handleNetworkRequest<List<Category>>(
      remoteRequest: _menuRemoteDataSource.getCategories,
      cacheData: _menuLocalDataSource.insertCategories,
      localRequest: _menuLocalDataSource.getCategories,
    );
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts(String branchId) async {
    return _networkInfo.handleNetworkRequest<List<Product>>(
      remoteRequest: () => _menuRemoteDataSource.getProducts(branchId),
      cacheData: _menuLocalDataSource.insertProducts,
      localRequest: () => _menuLocalDataSource.getProducts(),
    );
  }

  @override
  Future<Either<Failure, List<Flavor>>> getFlavors() async {
    return _networkInfo.handleNetworkRequest<List<Flavor>>(
      remoteRequest: _menuRemoteDataSource.getFlavors,
      cacheData: _menuLocalDataSource.insertFlavors,
      localRequest: _menuLocalDataSource.getFlavors,
    );
  }

  @override
  Future<Either<Failure, List<Question>>> getQuestions() async {
    return _networkInfo.handleNetworkRequest<List<Question>>(
      remoteRequest: _menuRemoteDataSource.getQuestions,
      cacheData: _menuLocalDataSource.insertQuestions,
      localRequest: _menuLocalDataSource.getQuestions,
    );
  }
}
