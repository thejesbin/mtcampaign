import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/settings_controller.dart';
import 'package:mtcampaign/controller/withdraw_history_controller.dart';
import 'package:mtcampaign/view/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';

class ScreenWallet extends StatelessWidget {
  ScreenWallet({super.key});
  TextEditingController amountController = TextEditingController();
  ValueNotifier<int> buttonStatus = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    var withdrawHistory = Get.put(WithdrawHistoryController());
    var settings = Get.put(SettingsController());
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: RefreshIndicator(
          onRefresh: () async {
            withdrawHistory.getData();
          },
          child: Center(
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
                      "Withdrawal",
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  width: mwidth * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40)),
                  alignment: Alignment.center,
                  child: Text(
                    "Minimum Withdrawal Amount is ₹${settings.settingsList[0].minWithdrawal}",
                    style: const TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Amount",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: mwidth * 0.8,
                  height: 70,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "₹",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "${settings.settingsList[0].minWithdrawal} ~ ${settings.settingsList[0].maxWithdrawal}"),
                          ))
                        ],
                      ),
                      Container(
                        height: 1,
                        width: mwidth * 0.8,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Note: Payment will be send on\n registered paytm number",
                  style: TextStyle(
                    color: Color.fromARGB(255, 245, 23, 7),
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: mheight * 0.12,
                ),
                Image.asset(
                  "assets/secure.png",
                  height: 30,
                ),
                SizedBox(
                  height: mheight * 0.01,
                ),
                InkWell(
                  onTap: () {
                    if (buttonStatus.value == 1) {
                    } else {
                      withdraw();
                    }
                  },
                  child: ValueListenableBuilder(
                      valueListenable: buttonStatus,
                      builder: (context, val, child) {
                        return ButtonWidget(
                          widget: val == 1
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                        );
                      }),
                ),
                SizedBox(
                  height: mheight * 0.05,
                ),
                Obx(
                  () => withdrawHistory.isLoading.isTrue ||
                          settings.isLoading.isTrue
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : withdrawHistory.isEmpty.isTrue ||
                              settings.isEmpty.isTrue
                          ? const Center(child: Text("No Withdrawals"))
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                var withdraw =
                                    withdrawHistory.withdrawHistoryList[i];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 70,
                                    width: mwidth * 0.9,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/paytm.png"),
                                                  fit: BoxFit.fitWidth)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Via Paytm",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${withdraw.date}\n ${withdraw.time}",
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          "₹${withdraw.amount}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                            height: 30,
                                            width: 65,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: withdraw.status == "paid"
                                                  ? Colors.green
                                                  : withdraw.status == "pending"
                                                      ? Colors.orange
                                                      : Colors.red,
                                            ),
                                            child: Text(
                                              "${withdraw.status}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, i) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount:
                                  withdrawHistory.withdrawHistoryList.length),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  withdraw() async {
    var amount = amountController.text;
    if (amount.isEmpty) {
      Get.snackbar(
        "Oh no!",
        "Please enter an amount",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      buttonStatus.value = 1;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var uid = sharedPreferences.getString('uid');
      d.Dio dio = d.Dio();
      var formData = d.FormData.fromMap({'uid': uid, 'amount': amount});
      var response = await dio.post(withdrawUrl, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        buttonStatus.value = 0;
        if (response.data['status'] == true) {
          Get.snackbar(
            "Woo hoo",
            response.data['msg'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Oh no!",
            response.data['msg'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        buttonStatus.value = 0;
      }
    }
  }
}
