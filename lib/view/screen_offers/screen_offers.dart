import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/interstitial_ad_controller.dart';
import 'package:mtcampaign/controller/offers_controller.dart';
import 'package:mtcampaign/models/offers_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:startapp_sdk/startapp.dart';
import '../../controller/camp_history_controller.dart';
import '../../controller/offer_history_controller.dart';
import '../../controller/start_ad_controller.dart';
import '../../core/constants.dart';
import '../screen_offer_details/screen_offer_details.dart';
import '../widgets/shimmer_loading_widget.dart';

class ScreenOffers extends StatelessWidget {
  const ScreenOffers({super.key});

  @override
  Widget build(BuildContext context) {
    var offers = Get.put(OffersController());
    var history = Get.put(CampHistoryController());
    var startAd = Get.put(StartAdController());
    var intAd = Get.put(InterStitialAdController());
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            offers.getData();
          },
          child: SingleChildScrollView(
            child: SafeArea(
                child: Center(
              child: Obx(
                () => offers.isLoading.isTrue
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "OFFERS",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: mwidth * 0.9,
                            height: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ShimmerLoadingWidget(),
                        ],
                      )
                    : Column(
                        children: [
                          startAd.mrecAd != null
                              ? StartAppBanner(startAd.mrecAd!)
                              : SizedBox(height: 1),
                          TabBar(
                              labelColor: Colors.black,
                              indicatorColor: Colors.blue,
                              tabs: [
                                Tab(
                                  text: "Offers",
                                ),
                                Tab(
                                  text: "History",
                                )
                              ]),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: TabBarView(children: [
                              offersList(offers, intAd, mwidth),
                              historyList(history, intAd, mwidth)
                            ]),
                          )
                        ],
                      ),
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget historyList(CampHistoryController campHistory,
      InterStitialAdController intAd, double mwidth) {
    return ListView.separated(
      itemBuilder: (context, i) {
        var history = campHistory.campHistoryList[i];
        return Container(
          height: 50,
          width: mwidth,
          alignment: Alignment.center,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(history.image.toString()),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                history.title.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                height: 15,
                width: 60,
                decoration: BoxDecoration(
                  color: history.status == "success"
                      ? Colors.green
                      : history.status == "pending"
                          ? Colors.yellow
                          : Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text(
                  history.status.toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, i) => const Divider(
        thickness: 1,
      ),
      itemCount: campHistory.campHistoryList.length,
    );
  }

  Widget offersList(
      OffersController offers, InterStitialAdController intAd, double mwidth) {
    return ListView.separated(
      itemBuilder: (context, i) {
        var offer = offers.offersList[i];
        return InkWell(
          onTap: () => {
            intAd.showInterstitialAd(),
            Get.to(() => ScreenOfferDetails(
                  offer: offer,
                ))
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 70,
                width: mwidth * 0.95,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage("${offer.image}"),
                        fit: BoxFit.cover,
                      )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 22,
                          width: 110,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${offer.name}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          "Try the app to get reward",
                          style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Try Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
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
            ),
          ),
        );
      },
      separatorBuilder: (context, i) => const SizedBox(
        height: 10,
      ),
      itemCount: offers.offersList.length,
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
