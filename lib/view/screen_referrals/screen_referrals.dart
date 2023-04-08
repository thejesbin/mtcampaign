import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/my_referrals_controller.dart';

class ScreenReferrals extends StatelessWidget {
  const ScreenReferrals({super.key});

  @override
  Widget build(BuildContext context) {
    var referrals = Get.put(MyReferralsController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Obx(
                ()=> Center(
                      child: referrals.isLoading.isTrue
                          ?const Center(child:  LinearProgressIndicator())
                          :referrals.isEmpty.isTrue?Image.asset("assets/no-data.gif"): Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Table(
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(5),
                        2: FlexColumnWidth(2)
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(children: [
                          Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "ID",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "NAME",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "DATE",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ]),
                        ...List.generate(
                            referrals.myReferralsList.length,
                            (index) => TableRow(children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text("${index + 1}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${referrals.myReferralsList[index].name}",
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          "${referrals.myReferralsList[index].date}"),
                                    ],
                                  )
                                ]))
                      ],
                    ),
                  ],
                ),
                    ),
              ))),
    );
  }
}
