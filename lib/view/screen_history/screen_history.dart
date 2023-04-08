import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/offer_history_controller.dart';

class ScreenHistory extends StatelessWidget {
  const ScreenHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var offerHistory = Get.put(OfferHistoryController());

    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Obx(
             ()=> Center(
                      child: offerHistory.isLoading.isTrue
                ? const LinearProgressIndicator()
                : offerHistory.isEmpty.isTrue
                    ? Image.asset("assets/no-data.gif")
                    : Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                var history = offerHistory.offerHistoryList[i];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Container(
                                        height: 50,
                                        width: mwidth * 0.9,
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${i + 1})  ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "${history.campName}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 15),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${history.date} ${history.time}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 8),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "₹${history.amount}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.green,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              },
                              separatorBuilder: (context, i) => const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: offerHistory.offerHistoryList.length)
                        ],
                      ),
                    ),
            )),
      ),
    );
  }
}
