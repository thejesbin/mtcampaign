import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/ad_helper.dart';


class BannerAdController extends GetxController{
 late BannerAd bottomBannerAd;
 var isLoaded=false.obs;
 void createBottomBannerAd() {
    bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
         isLoaded.value=true;
         print("Ad loaded");
        },
        onAdFailedToLoad: (ad, error) {
          print("Ad loading failed");
          ad.dispose();
        },
      ),
    );
    bottomBannerAd.load();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    createBottomBannerAd();
  }
}