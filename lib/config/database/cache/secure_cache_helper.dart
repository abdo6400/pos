import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'cache_consumer.dart';

class SecureCacheHelper extends CacheConsumer {
  final FlutterSecureStorage sharedPref;

  SecureCacheHelper({required this.sharedPref});
  @override
  Future<void> clearAll() async {
    await sharedPref.deleteAll();
  }

  @override
  Future<String?> get({required String key}) async {
    return await sharedPref.read(key: key);
  }

  @override
  Future<void> save({required String key, required String value}) async {
    await sharedPref.write(key: key, value: value);
  }

  @override
  Future<void> clearValue({required String key}) async {
    await sharedPref.delete(key: key);
  }
}
