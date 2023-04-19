import 'package:dio/dio.dart';
import 'package:mtcampaign/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/camp_history_model.dart';

class CampHistoryServices {
  Future<List<CampHistoryModel>?> getCampHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uid = sharedPreferences.getString('uid');

    var formData = FormData.fromMap({'uid': uid});
    final Response response = await Dio().post(
      offerHistoryUrl,
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.data['result']);
      if (response.data['result'] == null) {
        return null;
      } else {
        final campHistoryList = (response.data['result'] as List).map((e) {
          return CampHistoryModel.fromJson(e);
        }).toList();

        return campHistoryList;
      }
    } else {
      return null;
    }
  }
}
