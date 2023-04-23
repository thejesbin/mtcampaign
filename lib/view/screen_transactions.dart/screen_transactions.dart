import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/transactions_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/shimmer_loading_widget.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    var state = Get.put(TransactionsController());
    var listLength = 0;
    if (state.transactionsList.length > 300) {
      listLength = state.transactionsList.length ~/ 3;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          state.getData();
        },
        child: SingleChildScrollView(
          child: SafeArea(
              child: Obx(
            () => state.isLoading.isTrue
                ? Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "All Transactions",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ShimmerLoadingWidget(),
                    ],
                  )
                : state.isEmpty.isTrue
                    ? Center(
                        child: Image.asset("assets/no-data.gif"),
                      )
                    : Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "All Transactions",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  var transaction = state.transactionsList[i];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SizedBox(
                                      height: 75,
                                      width: mwidth * 0.9,
                                      child: Stack(
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            elevation: 5,
                                            child: Container(
                                              height: 60,
                                              width: mwidth * 95,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 0.5)),
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        transaction.type ==
                                                                "credit"
                                                            ? Colors.green
                                                            : Colors.red,
                                                    child: transaction.type ==
                                                            "credit"
                                                        ? Icon(
                                                            Icons
                                                                .call_received_outlined,
                                                            color: Colors.white,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .call_made_outlined,
                                                            color: Colors.white,
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          width: mwidth * 0.5,
                                                          child: Text(
                                                            transaction.comment
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width: mwidth * 0.7,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              transaction.date
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 9,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              transaction.time
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 9,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    "₹${transaction.amount}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: transaction.type ==
                                                              "credit"
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              height: 15,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color:
                                                    transaction.type == "credit"
                                                        ? Colors.green
                                                        : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                transaction.type.toString(),
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, i) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: state.transactionsList.length > 50
                                    ? 50
                                    : state.transactionsList.length)
                          ],
                        ),
                      ),
          )),
        ),
      ),
    );
  }
}
