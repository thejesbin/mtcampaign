import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/ad_helper.dart';


class InterStitialAdController extends GetxController{
  InterstitialAd? interstitialAd;
  
void createInterstitialAd() {
  InterstitialAd.load(
    adUnitId: AdHelper.interstitialAdUnitId,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        interstitialAd = ad;
        print("Interstitial loaded");
      },
      onAdFailedToLoad: (LoadAdError error) {
         print("Interstitial not loaded");
        interstitialAd = null;
        createInterstitialAd();
      },
    ),
  );
}
void showInterstitialAd() {
  if (interstitialAd != null) {
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
         ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
         createInterstitialAd();
      },
    );
    interstitialAd!.show();
  }
}
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    createInterstitialAd();
  }
}