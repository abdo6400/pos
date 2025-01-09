import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/setting_model.dart';

abstract class SettingsRemoteDataSource {
  Future<List<SettingModel>> getSettings(String branchId);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SettingsRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;
  @override
  Future<List<SettingModel>> getSettings(String branchId) async {
    final response = await _apiConsumer.get(EndPoints.getSettings,
        queryParameters: {ApiKeys.warehouse: branchId});
    return List<SettingModel>.from(
        response[EndPoints.response].map((x) => SettingModel.fromJson(x)));
  }
}
