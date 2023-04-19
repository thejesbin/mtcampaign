import 'package:get/get.dart';

import '../models/camp_history_model.dart';
import '../services/camp_history_services.dart';

class CampHistoryController extends GetxController {
  var campHistoryList = <CampHistoryModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    isLoading.value = true;
    var data = await CampHistoryServices().getCampHistory();

    try {
      if (data != null) {
        campHistoryList.value = data;
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
