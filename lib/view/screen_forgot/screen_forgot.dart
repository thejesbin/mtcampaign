import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';

class ScreenForgot extends StatelessWidget {
  ScreenForgot({super.key});

  ValueNotifier<int> buttonStatus = ValueNotifier(0);
  TextEditingController emailController = TextEditingController();
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
              Image.asset("assets/forgot.png"),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  SizedBox(width: 20),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 28,
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
                obscure: false,
                controller: emailController,
                icon: Icons.email_outlined,
                hint: "Email",
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: mheight * 0.15,
              ),
              InkWell(
                onTap: () => forgot(),
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
                                ),
                              ),
                      );
                    }),
              ),
              SizedBox(
                height: mheight * 0.03,
              ),
            ],
          ),
        )),
      ),
    );
  }

  forgot() async {
    var email = emailController.text;

    if (email.isEmpty || !email.contains("@")) {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Oh no",
        "Invalid Email",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      buttonStatus.value = 1;
      d.Dio dio = d.Dio();
      var formData = d.FormData.fromMap({'email': email});
      var response = await dio.post(forgotUrl, data: formData);
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
