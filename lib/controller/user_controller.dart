
import 'package:get/get.dart';
import 'package:mtcampaign/models/user_model.dart';
import '../services/user_services.dart';

class UserController extends GetxController {
  var userList = <UserAccountModel>[].obs;
  var isLoading = true.obs;
  var isEmpty = true.obs;

  getData() async {
    print("hi");
    isLoading.value = true;
    var data = await UserServices().getUser();

    try {
      if (data != null) {
        userList.value = data;
        isLoading.value = false;
        isEmpty.value = false;
      } else {
        print("data is null");
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
