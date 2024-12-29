import '../../core/utils/constants.dart';
import '../../core/utils/storage.dart';

class ConstantLocator {
  static Future<void> init() async {
    locator.registerLazySingleton<Storage>(() => Storage(cache: locator()));
  }
}
