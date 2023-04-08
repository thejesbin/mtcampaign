import 'package:get/get.dart';

import '../models/banners_model.dart';
import '../services/banners_services.dart';

class BannersController extends GetxController {
  var bannersList = <BannersModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    isLoading.value = true;
    var data = await BannersServices().getBanners();

    try {
      if (data != null) {
        bannersList.value = data;
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
