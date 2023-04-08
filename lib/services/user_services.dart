import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants.dart';
import '../models/user_model.dart';

class UserServices {
  Future<List<UserAccountModel>?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uid = sharedPreferences.getString('uid');
    var formData = FormData.fromMap({'uid': uid});
    final Response response = await Dio().post(
      userDataUrl,
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data == null) {
      } else {
        final userList = (response.data as List).map((e) {
          return UserAccountModel.fromJson(e);
        }).toList();
        return userList;
      }
    } else {
      return null;
    }
    return null;
  }
}
