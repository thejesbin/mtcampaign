import 'package:dio/dio.dart';
import 'package:mtcampaign/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transactions_model.dart';

class TransactionsServices {
  Future<List<TransactionsModel>?> getTransactions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uid = sharedPreferences.getString('uid');

    var formData = FormData.fromMap({'uid': uid});
    final Response response = await Dio().post(
      transactionsUrl,
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final transactionsList = (response.data['result'] as List).map((e) {
        return TransactionsModel.fromJson(e);
      }).toList();

      return transactionsList;
    } else {
      return null;
    }
  }
}
