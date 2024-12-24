import 'dart:convert';

import '../../config/database/cache/cache_consumer.dart';
import '../entities/auth_tokens.dart';
import '../models/auth_tokens_model.dart';
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
    String accessToken,
    Map<String, dynamic> user,
  ) async {
    await _cache.save(
        key: SharedPrefEnums.AccessToken.name, value: accessToken);
    await _cache.save(key: SharedPrefEnums.user.name, value: jsonEncode(user));
  }

  Future<bool> isAuthenticatedState() async {
    return await _cache.get(key: SharedPrefEnums.AccessToken.name) != null &&
        await _cache.get(key: SharedPrefEnums.RefrashToken.name) != null;
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
}
