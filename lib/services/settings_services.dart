import 'package:dio/dio.dart';

import '../core/constants.dart';
import '../models/settings_model.dart';

class SettingsServices {
  Future<List<SettingsModel>?> getSettings() async {
    final Response response = await Dio().get(
      settingsUrl,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data['result'] == null) {
      } else {
        final settingsList = (response.data['result'] as List).map((e) {
          return SettingsModel.fromJson(e);
        }).toList();
        return settingsList;
      }
    } else {
      return null;
    }
    return null;
  }
}
