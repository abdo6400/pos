import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/utils/constants.dart';
import '../database/api/api_consumer.dart';
import '../database/api/dio_consumer.dart';
import '../database/cache/cache_consumer.dart';
import '../database/cache/secure_cache_helper.dart';
import '../database/network/netwok_info.dart';
import 'app_locator.dart';
import 'auth_locator.dart';

class GlobalLocator {
  static Future<void> init() async {
    await AuthLocator.init();
    await AppLocator.init();
    // Internal
    await EasyLocalization.ensureInitialized();
    final themeMode =
        await AdaptiveTheme.getThemeMode() ?? AdaptiveThemeMode.system;
    locator.registerLazySingleton<AdaptiveThemeMode>(() => themeMode);
    locator.registerLazySingleton<CacheConsumer>(
        () => SecureCacheHelper(sharedPref: locator()));
    locator.registerLazySingleton<ApiConsumer>(
        () => DioConsumer(client: locator(), networkInfo: locator()));
    
    // Extarnal
    locator.registerLazySingleton(() => Dio());
    locator.registerLazySingleton(() => FlutterSecureStorage());
    locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  }
}
