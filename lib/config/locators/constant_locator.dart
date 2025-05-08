import '../../core/bloc/cubit/printing_cubit.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/storage.dart';

class ConstantLocator {
  static Future<void> init() async {
    
    locator
        .registerLazySingleton<PrintingCubit>(() => PrintingCubit(locator()));
    locator.registerLazySingleton<Storage>(() => Storage(cache: locator()));
  }
}
