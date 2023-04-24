import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/settings_controller.dart';
import 'package:mtcampaign/controller/user_controller.dart';
import 'package:mtcampaign/core/constants.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/dynamic_link.dart';

class ScreenRefer extends StatelessWidget {
  const ScreenRefer({super.key});

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    var settings = Get.put(SettingsController());
    var user = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Obx(
            () => settings.isLoading.isTrue || user.isLoading.isTrue
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Image.asset("assets/refer.png"),
                      SizedBox(
                        height: mheight * 0.1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.black)),
                            child: const Text(
                              "1",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            "Share your code and invite your friends",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Itim",
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 25,
                            width: 3,
                            color: Colors.black,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.black)),
                            child: const Text(
                              "2",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "When your friend completes ${settings.settingsList[0].refferOffers} offers",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Itim",
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30)),
                            alignment: Alignment.center,
                            child: Text(
                              "You Get ₹${settings.settingsList[0].perRefer}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: "Itim",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "+",
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: "Itim",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30)),
                            alignment: Alignment.center,
                            child: Text(
                              "Additional ${settings.settingsList[0].earningPercentage}% of\n your friends earnings",
                              style: const TextStyle(
                                fontFamily: "Itim",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: mwidth,
                        height: 0.5,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Share your referral code",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Itim",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: mwidth * 0.8,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Text(
                              "${user.userList[0].user![0].referCode}",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontFamily: "Itim",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          "${user.userList[0].user![0].referCode}"));
                                  Get.snackbar(
                                    "Woo hoo",
                                    "Copied to clipboard",
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.blue,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Or share via",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 9,
                          fontFamily: "Itim",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.01,
                      ),
                      InkWell(
                          onTap: () async {
                            String generatedDeeplink =
                                await FirebaseDynamiclinkService
                                    .createDynamicLink(user
                                        .userList[0].user![0].referCode
                                        .toString());

                            Share.share(
                                "Earn lots of money with $appName.\n Download now:- $generatedDeeplink");
                          },
                          child: Image.asset(
                            "assets/share.jpeg",
                            height: 70,
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 40,
                        width: mwidth * 0.5,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Total Referrals: ${user.userList[0].totalReferrals}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Itim",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.05,
                      ),
                    ],
                  ),
          ),
        )),
      ),
    );
  }
}
