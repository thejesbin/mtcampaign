import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants.dart';
import '../models/withdraw_history_model.dart';

class WithdrawHistoryServices {
  Future<List<WithdrawHistoryModel>?> getWithdrawHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uid = sharedPreferences.getString('uid');
    var formData = FormData.fromMap({'uid': uid});
    final Response response = await Dio().post(
      withdrawHistoryUrl,
      data: formData,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data['result'] == null) {
      } else {
        final withdrawHistoryList = (response.data['result'] as List).map((e) {
          return WithdrawHistoryModel.fromJson(e);
        }).toList();
        return withdrawHistoryList;
      }
    } else {
      return null;
    }
    return null;
  }
}
