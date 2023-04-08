import 'package:dio/dio.dart';
import 'package:mtcampaign/core/constants.dart';

import '../models/offers_model.dart';

class OffersServices {
  Future<List<OffersModel>?> getOffers() async {
    final Response response = await Dio().post(
      offersUrl,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final offersList = (response.data['result'] as List).map((e) {
        return OffersModel.fromJson(e);
      }).toList();

      return offersList;
    } else {
      return null;
    }
  }
}
