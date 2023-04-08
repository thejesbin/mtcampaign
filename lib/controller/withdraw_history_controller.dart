import 'package:get/get.dart';
import '../models/withdraw_history_model.dart';
import '../services/withdraw_history_services.dart';

class WithdrawHistoryController extends GetxController {
  var withdrawHistoryList = <WithdrawHistoryModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    isLoading.value = true;
    var data = await WithdrawHistoryServices().getWithdrawHistory();

    try {
      if (data != null) {
        withdrawHistoryList.value = data;
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
