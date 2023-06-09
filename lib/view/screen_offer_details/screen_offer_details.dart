// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants.dart';
import '../../models/offers_model.dart';

class ScreenOfferDetails extends StatelessWidget {
  final OffersModel offer;
  const ScreenOfferDetails({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    double mheight = MediaQuery.of(context).size.height;
    double mwidth = MediaQuery.of(context).size.width;

    const find = "<br>";
    var steps = offer.steps?.replaceAll(find, "");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(offer.banner.toString()))),
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
                                fontFamily: "Itim",
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
                            fontFamily: "Itim",
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
                            fontFamily: "Itim",
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
                  height: 100,
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
                            "About",
                            style: TextStyle(
                              fontFamily: "Itim",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              offer.about.toString(),
                              style: TextStyle(
                                fontFamily: "Itim",
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                                fontFamily: "Itim",
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
                              fontFamily: "Itim",
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
                                  fontFamily: "Itim",
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
                                    fontFamily: "Itim",
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
                                    fontFamily: "Itim",
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
            ],
          ),
        )),
      ),
      bottomNavigationBar: Row(
        children: [
          InkWell(
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              var uid = sharedPreferences.getString('uid');
              // var url = Uri.parse(
              //     "${offer.url}&aff_click_id=$uid&sub_aff_id=${offer.id}");
              // await launchUrl(url, mode: LaunchMode.externalApplication);

              //verify offer

              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Container(
                        height: 200,
                        width: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Redirecting to offer...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Itim",
                                ),
                              ),
                            ]),
                      ),
                    );
                  });

              d.Dio dio = d.Dio();
              var formData =
                  d.FormData.fromMap({'uid': uid, 'oid': offer.offerid});
              var response = await dio.post(startOfferUrl, data: formData);
              if (response.statusCode == 200 || response.statusCode == 201) {
                if (response.data['status'] == true) {
                  Get.snackbar(
                    "Woo hoo",
                    response.data['msg'],
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );

                  Navigator.of(context).pop();
                  var url = Uri.parse(
                      "${offer.url}&aff_click_id=$uid&sub_aff_id=${offer.id}");
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  Get.snackbar(
                    "Oh no!",
                    response.data['msg'],
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              } else {
                Get.snackbar(
                  "Oh no!",
                  "Error occured try again!",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
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
    );
  }
}
