import 'package:dio/dio.dart';
import 'package:mtcampaign/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/offer_history_model.dart';

class OfferHistoryServices {
  Future<List<OfferHistoryModel>?> getOfferHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uid = sharedPreferences.getString('uid');

    var formData = FormData.fromMap({'uid': uid});
    final Response response = await Dio().post(
      offerHistoryUrl,
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data['result'] == null) {
        return null;
      } else {
        final offerHistoryList = (response.data['result'] as List).map((e) {
          return OfferHistoryModel.fromJson(e);
        }).toList();

        return offerHistoryList;
      }
    } else {
      return null;
    }
  }
}
