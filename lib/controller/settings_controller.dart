import 'package:get/get.dart';

import '../models/settings_model.dart';
import '../services/settings_services.dart';

class SettingsController extends GetxController {
  var settingsList = <SettingsModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    isLoading.value = true;
    var data = await SettingsServices().getSettings();

    try {
      if (data != null) {
        settingsList.value = data;
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
