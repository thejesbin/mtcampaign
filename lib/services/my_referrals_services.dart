import 'package:dio/dio.dart';
import 'package:mtcampaign/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/my_referrals_model.dart';


class MyReferralsServices {
  Future<List<MyReferralsModel>?> getMyReferrals() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uid = sharedPreferences.getString('uid');

    var formData = FormData.fromMap({'uid': uid});
    final Response response = await Dio().post(
      myReferralsUrl,
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data['result'] == null) {
        return null;
      } else {
        final myReferralsList = (response.data['result'] as List).map((e) {
          return MyReferralsModel.fromJson(e);
        }).toList();

        return myReferralsList;
      }
    } else {
      return null;
    }
  }
}
