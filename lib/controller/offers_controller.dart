
import 'package:get/get.dart';
import '../models/offers_model.dart';
import '../services/offers_services.dart';

class OffersController extends GetxController {
  var offersList = <OffersModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    isLoading.value = true;
    var data = await OffersServices().getOffers();

    try {
      if (data != null) {
        offersList.value = data;
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
