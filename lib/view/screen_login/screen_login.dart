import 'package:dio/dio.dart' as d;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/view/screen_forgot/screen_forgot.dart';
import 'package:mtcampaign/view/screen_signup/screen_signup.dart';
import 'package:mtcampaign/view/splash_screen/splash_screen.dart';
import 'package:mtcampaign/view/widgets/button_widget.dart';
import 'package:mtcampaign/view/widgets/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../screen_main/screen_main.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      handleLink(deepLink);
    }
  }

  void handleLink(Uri url) {
    List<String> separatedLink = [];
    separatedLink.addAll(url.path.split("/"));
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ScreenSignup(referCode: separatedLink[1])));
  }

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  ValueNotifier<int> buttonStatus = ValueNotifier(0);

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
              Image.asset("assets/login.png"),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  SizedBox(width: 20),
                  Text(
                    "Login",
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
                height: 35,
              ),
              InputWidget(
                obscure: false,
                controller: phoneController,
                icon: Icons.phone_android_outlined,
                hint: "Phone Number",
                inputType: TextInputType.phone,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                obscure: true,
                controller: passwordController,
                icon: Icons.lock_outline_rounded,
                hint: "Password",
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.to(() => ScreenForgot()),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: "Itim",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: mheight * 0.15,
              ),
              InkWell(
                onTap: () => login(),
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
                                  fontFamily: "Itim",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                      );
                    }),
              ),
              SizedBox(
                height: mheight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New to $appName?",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Itim",
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => ScreenSignup())),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: "Itim",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  login() async {
    var phone = phoneController.text;
    var password = passwordController.text;
    if (phone.length != 10) {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Oh no",
        "Invalid phone number",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (password.length < 6) {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Oh no",
        "Password must need 6 letters",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      buttonStatus.value = 1;
      d.Dio dio = d.Dio();
      var formData = d.FormData.fromMap({'phone': phone, 'password': password});
      var response = await dio.post(loginUrl, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        buttonStatus.value = 0;
        if (response.data['status'] == true) {
          Get.snackbar(
            "Woo hoo",
            response.data['msg'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('uid', response.data['uid']);
          print(sharedPreferences.getString('uid'));
          Get.offAll(() => ScreenSplash());
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
