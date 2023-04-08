import 'package:get/get.dart';

import '../models/offer_history_model.dart';
import '../services/offer_history_services.dart';

class OfferHistoryController extends GetxController {
  var offerHistoryList = <OfferHistoryModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    isLoading.value = true;
    var data = await OfferHistoryServices().getOfferHistory();

    try {
      if (data != null) {
        offerHistoryList.value = data;
        isLoading.value = false;
        isEmpty.value = false;
      } else {
        isLoading.value = false;
        isEmpty.value = true;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("error", "$e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
