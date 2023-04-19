import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/banner_ad_controller.dart';
import 'package:mtcampaign/controller/interstitial_ad_controller.dart';
import 'package:mtcampaign/controller/settings_controller.dart';
import 'package:mtcampaign/controller/start_ad_controller.dart';
import 'package:mtcampaign/view/screen_login/screen_login.dart';
import 'package:mtcampaign/view/screen_main/screen_main.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/banners_controller.dart';
import '../../controller/my_referrals_controller.dart';
import '../../controller/offer_history_controller.dart';
import '../../controller/offers_controller.dart';
import '../../controller/user_controller.dart';
import '../../controller/withdraw_history_controller.dart';
import '../../core/constants.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(milliseconds: 1), () async {
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
      await OneSignal.shared.setAppId(onesignalAppId);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var uid = sharedPreferences.getString('uid');
      if (uid != null) {
        Get.put(BannersController());
        Get.put(UserController());
        Get.put(OfferHistoryController());
        Get.put(OffersController());
        Get.put(WithdrawHistoryController());
        Get.put(MyReferralsController());
        Get.put(BannerAdController());
        Get.put(InterStitialAdController());
        Get.put(StartAdController());
      }
      Timer(Duration(milliseconds: 1500), () async {
        print(uid);
        if (uid == null) {
          Get.offAll(() => ScreenLogin());
        } else {
          Get.offAll(() => ScreenMain());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var settings = Get.put(SettingsController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.black,
        backgroundImage: AssetImage("assets/logo.jpeg"),
      )),
    );
  }
}
