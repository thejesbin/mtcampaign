import 'package:flutter/material.dart';
import 'package:startapp_sdk/startapp.dart';
import 'package:get/get.dart';

class StartAdController extends GetxController {
  var startAppSdk = StartAppSdk();
  StartAppBannerAd? mrecAd;
  void loadAd() {
    startAppSdk
        .loadBannerAd(
      StartAppBannerType.MREC,
      prefs: const StartAppAdPreferences(adTag: 'secondary'),
    )
        .then((ad) {
      mrecAd = ad;
    }).onError<StartAppException>((ex, stackTrace) {
      debugPrint("Error loading Mrec ad: ${ex.message}");
    }).onError((error, stackTrace) {
      debugPrint("Error loading Mrec ad: $error");
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAd();
  }
}
