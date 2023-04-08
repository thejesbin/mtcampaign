import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mtcampaign/controller/banners_controller.dart';
import 'package:mtcampaign/controller/my_referrals_controller.dart';
import 'package:mtcampaign/controller/offer_history_controller.dart';
import 'package:mtcampaign/controller/offers_controller.dart';
import 'package:mtcampaign/controller/transactions_controller.dart';
import 'package:mtcampaign/controller/user_controller.dart';
import 'package:mtcampaign/controller/withdraw_history_controller.dart';
import 'package:mtcampaign/core/constants.dart';
import 'package:mtcampaign/view/screen_history/screen_history.dart';
import 'package:mtcampaign/view/screen_home/screen_home.dart';
import 'package:mtcampaign/view/screen_offers/screen_offers.dart';
import 'package:mtcampaign/view/screen_refer/screen_refer.dart';
import 'package:mtcampaign/view/screen_wallet/screen_wallet.dart';
import 'package:mtcampaign/view/widgets/navigation_drawer_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../controller/banner_ad_controller.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  @override
  Widget build(BuildContext context) {
    var bannerAd = Get.put(BannerAdController());
    Get.put(BannersController());
    Get.put(UserController());
    Get.put(OfferHistoryController());
    Get.put(OffersController());
    Get.put(WithdrawHistoryController());
    Get.put(MyReferralsController());
    Get.put(TransactionsController());

    var pages = [
      ScreenHome(),
      ScreenOffers(),
      ScreenWallet(),
      ScreenRefer(),
      ScreenHistory()
    ];
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text(appName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: pages[bottomIndex],
      persistentFooterButtons: [
        Obx(() => bannerAd.isLoaded.isTrue
            ? SizedBox(
                height: bannerAd.bottomBannerAd.size.height.toDouble(),
                width: bannerAd.bottomBannerAd.size.width.toDouble(),
                child: AdWidget(ad: bannerAd.bottomBannerAd),
              )
            : const SizedBox(
                height: 0,
              ))
      ],
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: bottomIndex,
          onTap: (index) {
            setState(() {
              bottomIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.checklist_outlined),
              title: const Text("Offers"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.wallet),
              title: const Text("Wallet"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.group_outlined),
              title: const Text("Refer"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.list_alt_outlined),
              title: const Text("History"),
            )
          ]),
    );
  }
}
