import 'dart:convert';
import '../../config/database/cache/cache_consumer.dart';
import '../entities/auth_tokens.dart';
import '../entities/settings.dart';
import '../models/auth_tokens_model.dart';
import '../models/settings_model.dart';
import 'enums/shared_pref_enums.dart';

class Storage {
  final CacheConsumer _cache;

  Storage({required CacheConsumer cache}) : _cache = cache;
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
    String accessToken,
    Map<String, dynamic> user,
  ) async {
    await _cache.save(
        key: SharedPrefEnums.AccessToken.name, value: accessToken);
    await _cache.save(key: SharedPrefEnums.user.name, value: jsonEncode(user));
  }

  Future<bool> isAuthenticatedState() async {
    return await _cache.get(key: SharedPrefEnums.AccessToken.name) != null;
  }

  Future<String?> getAccessToken() async {
    return await _cache.get(key: SharedPrefEnums.AccessToken.name);
  }

  Future<AuthTokens?> getUser() async {
    final String? user = await _cache.get(key: SharedPrefEnums.user.name);
    return user == null ? null : AuthTokensModel.fromJson(jsonDecode(user));
  }

  Future<String?> getRefreshToken() async {
    return await _cache.get(key: SharedPrefEnums.RefrashToken.name);
  }

  Future<void> clearAuthTokenState() async {
    await _cache.clearValue(key: SharedPrefEnums.AccessToken.name);
    await _cache.clearValue(key: SharedPrefEnums.RefrashToken.name);
  }

  Future<void> saveSettings(Settings settings) async {
    await _cache.save(
        key: SharedPrefEnums.settings.name,
        value: jsonEncode(settings.toJson()));
  }

  Future<Settings?> getSettings() async {
    final String? settings =
        await _cache.get(key: SharedPrefEnums.settings.name);
    return settings == null
        ? null
        : SettingsModel.fromJson(jsonDecode(settings));
  }

  Future<void> clearUser() async {
    await _cache.clearValue(key: SharedPrefEnums.user.name);
  }
}
