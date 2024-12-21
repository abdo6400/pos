import '../../config/database/cache/cache_consumer.dart';
import 'constants.dart';
import 'enums/shared_pref_enums.dart';

class Storage {
  final _cache = locator<CacheConsumer>();
  Future<void> saveOnBoardingState() async {
    await _cache.save(
        key: SharedPrefEnums.onboarding.name,
        value: SharedPrefEnums.onboarding.name);
  }

  Future<bool> isOnBoardingState() async {
    return await _cache.get(key: SharedPrefEnums.onboarding.name) != null;
  }

  Future<void> clearOnBoardingState() async {
    _cache.clearValue(key: SharedPrefEnums.onboarding.name);
  }

  Future<void> saveAuthTokenState(
      String accessToken, String refreshToken) async {
    await _cache.save(
        key: SharedPrefEnums.AccessToken.name, value: accessToken);
    await _cache.save(
        key: SharedPrefEnums.RefrashToken.name, value: refreshToken);
  }

  Future<bool> isAuthenticatedState() async {
    return await _cache.get(key: SharedPrefEnums.AccessToken.name) != null &&
        await _cache.get(key: SharedPrefEnums.RefrashToken.name) != null;
  }

  Future<String?> getAccessToken() async {
    return await _cache.get(key: SharedPrefEnums.AccessToken.name);
  }
  Future<String?> getRefreshToken() async {
    return await _cache.get(key: SharedPrefEnums.RefrashToken.name);
  }

  Future<void> clearAuthTokenState() async {
    await _cache.clearValue(key: SharedPrefEnums.AccessToken.name);
    await _cache.clearValue(key: SharedPrefEnums.RefrashToken.name);
  }
}
