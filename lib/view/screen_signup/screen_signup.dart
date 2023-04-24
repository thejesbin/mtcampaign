import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/core/constants.dart';
import 'package:mtcampaign/view/screen_login/screen_login.dart';
import 'package:mtcampaign/view/screen_verify_otp/screen_verify_otp.dart';
import 'package:mtcampaign/view/widgets/button_widget.dart';
import 'package:mtcampaign/view/widgets/input_widget.dart';

class ScreenSignup extends StatelessWidget {
  String? referCode;
  ScreenSignup({super.key, this.referCode});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController referController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<int> buttonStatus = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    if (referCode != null) {
      referController.text = referCode!;
    }
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
              Image.asset("assets/signup.png"),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  SizedBox(width: 20),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Itim",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              InputWidget(
                controller: nameController,
                obscure: false,
                icon: Icons.face_outlined,
                hint: "Enter name",
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                obscure: false,
                controller: emailController,
                icon: Icons.email_outlined,
                hint: "Enter email",
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                obscure: false,
                controller: phoneController,
                icon: Icons.phone_android_outlined,
                hint: "Phone number",
                inputType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                obscure: false,
                controller: referController,
                icon: Icons.join_inner,
                hint: "Refer code(Optional)",
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                obscure: true,
                controller: passwordController,
                icon: Icons.lock_outline,
                hint: "Password",
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if (buttonStatus.value == 1) {
                  } else {
                    signUp();
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
                                  fontFamily: "Itim",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Joined us before?",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      letterSpacing: 1,
                      fontFamily: "Itim",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ScreenLogin())),
                    child: const Text(
                      "Login",
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

  signUp() async {
    var name = nameController.text;
    var email = emailController.text;
    var phone = phoneController.text;
    var refer = referController.text;
    var password = passwordController.text;
    if (name.length < 4) {
      Get.snackbar(
        "Oh no",
        "Name must need 4 letters",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (email.isEmpty || !email.contains("@gmail.com")) {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Oh no",
        "Invalid gmail",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (phone.length != 10) {
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
      var formData = d.FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'refer': refer,
        'password': password
      });
      var response = await dio.post(registerUrl, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        buttonStatus.value = 0;
        if (response.data['status'] == true) {
          Get.snackbar(
            "Woo hoo",
            response.data['msg'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAll(
            ScreenVerifyOtp(
                name: name,
                email: email,
                phone: phone,
                refer: refer,
                password: password),
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
