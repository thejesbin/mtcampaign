import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/my_referrals_controller.dart';
import 'package:mtcampaign/view/widgets/shimmer_loading_widget.dart';

class ScreenReferrals extends StatelessWidget {
  const ScreenReferrals({super.key});

  @override
  Widget build(BuildContext context) {
    var referrals = Get.put(MyReferralsController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          referrals.getData();
        },
        child: SingleChildScrollView(
            child: SafeArea(
                child: Obx(
          () => Center(
            child: referrals.isLoading.isTrue
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
                            "My Referrals",
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 1,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ShimmerLoadingWidget()
                    ],
                  )
                : referrals.isEmpty.isTrue
                    ? Image.asset("assets/no-data.gif")
                    : Column(
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
                                "My Referrals",
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
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      height: 30,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Row(children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text("${i + 1}"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          referrals.myReferralsList[i].name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Text(referrals.myReferralsList[i].date
                                            .toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ]),
                                    ),
                                  ),
                                );
                              },
                              itemCount: referrals.myReferralsList.length,
                            ),
                          )
                        ],
                      ),
          ),
        ))),
      ),
    );
  }
}
