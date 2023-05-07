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
import '../../controller/camp_history_controller.dart';
import '../../controller/onesignal_controller.dart';
import '../widgets/home_card_widget.dart';
import '../widgets/shimmer_loading_widget.dart';

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
    var users = Get.put(UserController());
    Get.put(OfferHistoryController());
    Get.put(OffersController());
    Get.put(WithdrawHistoryController());
    Get.put(MyReferralsController());
    Get.put(TransactionsController());
    Get.put(CampHistoryController());
    Get.put(OneSignalController());
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
        title: const Text(
          appName,
          style: TextStyle(
            fontFamily: "Itim",
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 5,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
                child: Obx(() => users.isLoading.isTrue
                    ? SizedBox(
                        height: 1,
                      )
                    : Container(
                        height: 15,
                        alignment: Alignment.center,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "₹${users.userList[0].user![0].balance}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "Itim",
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ))),
          ),
          InkWell(
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => users.isLoading.isTrue
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : users.isEmpty.isTrue
                              ? SizedBox(
                                  height: 1,
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    HomeCardWidget(
                                      amount:
                                          "${users.userList[0].user![0].balance}",
                                      title: "Total Balance",
                                      icon: Icons.account_balance_outlined,
                                      color: Colors.orange,
                                    ),
                                    HomeCardWidget(
                                      amount:
                                          "${double.parse(users.userList[0].totalEarnings.toString()).toInt()}",
                                      title: "Total Earnings",
                                      icon: Icons.file_open_outlined,
                                      color: Colors.green,
                                    ),
                                  ],
                                )),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCardWidget(
                            amount:
                                "${double.parse(users.userList[0].totalReferEarnings.toString()).toInt()}",
                            title: "Total Refer Earnings",
                            icon: Icons.check_circle,
                            color: Colors.red,
                          ),
                          HomeCardWidget(
                            amount:
                                "${double.parse(users.userList[0].totalWithdrawal.toString()).toInt()}",
                            title: "Total Withdrawal",
                            icon: Icons.handshake_outlined,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }),
            child: const CircleAvatar(
                radius: 10,
                child: Icon(
                  Icons.add,
                  size: 15,
                )),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Obx(() => users.isLoading.isTrue
          ? Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                ShimmerLoadingWidget(),
              ],
            )
          : pages[bottomIndex]),
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
