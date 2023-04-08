import 'package:dio/dio.dart';

import '../core/constants.dart';
import '../models/banners_model.dart';

class BannersServices {
  Future<List<BannersModel>?> getBanners() async {
   
    final Response response = await Dio().get(
      bannersUrl,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data['result'] == null) {
        return null;
      } else {
        final bannersList = (response.data['result'] as List).map((e) {
          return BannersModel.fromJson(e);
        }).toList();
        return bannersList;
      }
    } else {
      return null;
    }
    return null;
  }
}
