// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/banner_ad_controller.dart';
import 'package:mtcampaign/controller/interstitial_ad_controller.dart';
import 'package:mtcampaign/controller/offers_controller.dart';
import 'package:mtcampaign/controller/start_ad_controller.dart';
import 'package:mtcampaign/controller/user_controller.dart';
import 'package:mtcampaign/view/widgets/home_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:startapp_sdk/startapp.dart';
import '../../controller/banners_controller.dart';
import '../../core/constants.dart';
import '../../models/offers_model.dart';
import '../screen_offer_details/screen_offer_details.dart';
import '../widgets/shimmer_loading_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    var bannerController = Get.put(BannersController());
    var offers = Get.put(OffersController());
    var userController = Get.put(UserController());
    var bannerAd = Get.put(BannerAdController());

    var startAd = Get.put(StartAdController());
    var intAd = Get.put(InterStitialAdController());
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          offers.getData();
          userController.getData();
        },
        child: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => bannerController.isLoading.isTrue
                      ? LinearProgressIndicator()
                      : bannerController.isEmpty.isTrue
                          ? SizedBox(
                              height: 1,
                            )
                          : SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: CarouselSlider.builder(
                                itemCount: bannerController.bannersList.length,
                                itemBuilder: (BuildContext context, int index,
                                    int pageViewIndex) {
                                  final banners =
                                      bannerController.bannersList[index];
                                  return InkWell(
                                    onTap: () async {
                                      final Url = Uri.parse("${banners.url}");
                                      if (!await launchUrl(Url,
                                          mode:
                                              LaunchMode.externalApplication)) {
                                        throw 'Could not launch $Url';
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${banners.image}"),
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 2),
                                  aspectRatio: 2.5,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),
                ),
                SizedBox(
                  height: 25,
                ),
                startAd.mrecAd != null
                    ? StartAppBanner(startAd.mrecAd!)
                    : SizedBox(height: 1),
                Obx(
                  () => offers.isLoading.isTrue
                      ? ShimmerLoadingWidget()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            var offer = offers.offersList[i];
                            return InkWell(
                              onTap: () {
                                intAd.showInterstitialAd();
                                Get.to(() => ScreenOfferDetails(
                                      offer: offer,
                                    ));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      height: 240,
                                      width: 300,
                                      alignment: Alignment.topCenter,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 150,
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  image: DecorationImage(
                                                    image: NetworkImage(offers
                                                        .offersList[i].banner
                                                        .toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        offers
                                                            .offersList[i].name
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily: "Itim",
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        "Try the app to get reward",
                                                        style: const TextStyle(
                                                            fontFamily: "Itim",
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 25,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Text(
                                                      "Claim Now",
                                                      style: TextStyle(
                                                          fontFamily: "Itim",
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                              bottom: 50,
                                              left: 10,
                                              child: Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            offers.offersList[i]
                                                                .image
                                                                .toString()),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 50,
                                              right: 10,
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Text(
                                                  "₹${offers.offersList[i].amount}",
                                                  style: const TextStyle(
                                                      fontFamily: "Itim",
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                  // Container(
                                  //   height: 60,
                                  //   width: mwidth * 0.95,
                                  //   alignment: Alignment.center,
                                  //   child: Row(
                                  //     children: [
                                  //       Container(
                                  //         height: 50,
                                  //         width: 50,
                                  //         decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10),
                                  //             image: DecorationImage(
                                  //               image: NetworkImage(
                                  //                   "${offer.image}"),
                                  //               fit: BoxFit.cover,
                                  //             )),
                                  //       ),
                                  //       const SizedBox(
                                  //         width: 10,
                                  //       ),
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.center,
                                  //         children: [
                                  //           Row(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               Text(
                                  //                 "${offer.name}",
                                  //                 style: const TextStyle(
                                  //                   fontSize: 14,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   fontWeight: FontWeight.bold,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           const SizedBox(
                                  //             height: 4,
                                  //           ),
                                  //           const Text(
                                  //             "Try the app to get reward",
                                  //             style: TextStyle(
                                  //               fontSize: 12,
                                  //               overflow: TextOverflow.ellipsis,
                                  //               color: Colors.grey,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       const Spacer(),
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             "₹${offer.amount}",
                                  //             style: const TextStyle(
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.bold,
                                  //               color: Colors.green,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       const SizedBox(
                                  //         width: 15,
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  ),
                            );
                          },
                          separatorBuilder: (context, i) =>
                              SizedBox(height: 10),
                          itemCount: offers.offersList.length,
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => userController.isLoading.isTrue
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : userController.isEmpty.isTrue
                        ? SizedBox(
                            height: 1,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              HomeCardWidget(
                                amount:
                                    "${userController.userList[0].user![0].balance}",
                                title: "Total Balance",
                                icon: Icons.account_balance_outlined,
                                color: Colors.orange,
                              ),
                              HomeCardWidget(
                                amount:
                                    "${double.parse(userController.userList[0].totalEarnings.toString()).toInt()}",
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
                          "${double.parse(userController.userList[0].totalReferEarnings.toString()).toInt()}",
                      title: "Total Refer Earnings",
                      icon: Icons.check_circle,
                      color: Colors.red,
                    ),
                    HomeCardWidget(
                      amount:
                          "${double.parse(userController.userList[0].totalWithdrawal.toString()).toInt()}",
                      title: "Total Withdrawal",
                      icon: Icons.handshake_outlined,
                      color: Colors.blue,
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  buildBottomSheet(BuildContext context, OffersModel offer, double mwidth) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          double mheight = MediaQuery.of(context).size.height;
          const find = "<br>";
          var steps = offer.steps?.replaceAll(find, "");
          return SafeArea(
            child: Container(
              height: mheight * 0.9,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: mwidth,
                    height: 50,
                    color: Colors.blue,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 7,
                        ),
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Offer Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: mwidth * 0.95,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage("${offer.image}"),
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${offer.name}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              "Try the app to get reward",
                              style: TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "₹${offer.amount}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 4,
                    child: Container(
                        width: mwidth * 0.95,
                        height: 350,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Reward",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.warning,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "$steps",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            //
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.red,
                                ),
                                Expanded(
                                  child: Text(
                                    'Maximum it can take upto 24 hours to add your reward in $appName wallet',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.red,
                                ),
                                Expanded(
                                  child: Text(
                                    'You will not get any reward if you have already completed this offer',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.red,
                                ),
                                Expanded(
                                  child: Text(
                                    'Fake Register/Install may lead to your account deactivation',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  ),
                  Spacer(),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          var uid = sharedPreferences.getString('uid');
                          var url = Uri.parse(
                              "${offer.url}&aff_click_id=$uid&sub_aff_id=${offer.id}");
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          height: 50,
                          width: mwidth,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: const Text(
                            "Claim Offer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
