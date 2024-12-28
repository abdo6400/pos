import '../../core/utils/constants.dart';
import '../../features/menu/data/datasources/menu_remote_data_source.dart';
import '../../features/menu/data/repositories/menu_repository_impl.dart';
import '../../features/menu/domain/repositories/menu_repository.dart';
import '../../features/menu/domain/usecases/get_categories_usecase.dart';
import '../../features/menu/domain/usecases/get_products_usecase.dart';
import '../../features/menu/presentation/bloc/category/category_bloc.dart';
import '../../features/menu/presentation/bloc/product/product_bloc.dart';

class AppLocator {
  static Future<void> init() async {
    //menu
    locator.registerLazySingleton<CategoryBloc>(() => CategoryBloc(locator()));
    locator.registerLazySingleton<ProductBloc>(() => ProductBloc(locator()));
    locator.registerLazySingleton<GetProductsUseCase>(
        () => GetProductsUseCase(locator()));
    locator.registerLazySingleton<GetCategoriesUseCase>(
        () => GetCategoriesUseCase(locator()));
    locator.registerLazySingleton<MenuRepository>(
        () => MenuRepositoryImpl(menuRemoteDataSource: locator()));
    locator.registerLazySingleton<MenuRemoteDataSource>(
        () => MenuRemoteDataSourceImpl(apiConsumer: locator()));
  }
}
