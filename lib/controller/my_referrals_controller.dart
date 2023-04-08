import 'package:get/get.dart';

import '../models/my_referrals_model.dart';

import '../services/my_referrals_services.dart';

class MyReferralsController extends GetxController {
  var myReferralsList = <MyReferralsModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    isLoading.value = true;
    var data = await MyReferralsServices().getMyReferrals();

    try {
      if (data != null) {
        myReferralsList.value = data;
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
