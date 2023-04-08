
import 'package:get/get.dart';
import '../models/transactions_model.dart';
import '../services/transactions_services.dart';

class TransactionsController extends GetxController {
  var transactionsList = <TransactionsModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    isLoading.value = true;
    var data = await TransactionsServices().getTransactions();

    try {
      if (data != null) {
        transactionsList.value = data;
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
