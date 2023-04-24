import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/view/screen_login/screen_login.dart';
import 'package:pinput/pinput.dart';

import '../../core/constants.dart';
import '../widgets/button_widget.dart';

class ScreenVerifyOtp extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String refer;
  final String password;
  ScreenVerifyOtp(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.refer,
      required this.password});
  ValueNotifier<int> buttonStatus = ValueNotifier(0);
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset("assets/otp.png"),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                SizedBox(width: 20),
                Text(
                  "Verify Otp",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontFamily: "Itim",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "An otp has been send to $phone",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontFamily: "Itim",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: mwidth * 0.9,
              child: Pinput(
                autofocus: true,
                length: 6,
                controller: otpController,
                onCompleted: (val) => verifyOtp(),
              ),
            ),
            SizedBox(
              height: mheight * 0.2,
            ),
            InkWell(
              onTap: () {
                if (buttonStatus.value == 1) {
                } else {
                  verifyOtp();
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
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: "Itim",
                              ),
                            ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Did'nt get otp?",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Itim",
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    //resend otp
                    if (buttonStatus.value == 1) {
                    } else {
                      buttonStatus.value = 1;
                      d.Dio dio = d.Dio();
                      var formData = d.FormData.fromMap({
                        'name': name,
                        'email': email,
                        'phone': phone,
                        'refer': refer,
                        'password': password
                      });
                      var response =
                          await dio.post(registerUrl, data: formData);
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
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
                  },
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Itim",
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ))),
    );
  }

  verifyOtp() async {
    var otp = otpController.text;
    if (otp.isEmpty || otp.length < 4 || otp.length < 6) {
      Get.snackbar(
        "Oh no!",
        "Please submit your otp",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      buttonStatus.value = 1;
      d.Dio dio = d.Dio();
      var formData = d.FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'refer': refer,
        'password': password,
        'otp': otp
      });
      var response = await dio.post(verifyOtpUrl, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        buttonStatus.value = 0;
        if (response.data['status'] == true) {
          Get.snackbar(
            "Woo hoo",
            response.data['msg'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAll(() => ScreenLogin());
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
