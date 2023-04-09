import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/profile_card.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var user = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: user.isLoading.isTrue
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    SizedBox(
                      height: mheight * 0.05,
                    ),
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/profile.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                     "${user.userList[0].user![0].name}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      height: mheight * 0.1,
                    ),
                    ProfileCardWidget(
                        title: "Mobile Number",
                        value: "${user.userList[0].user![0].phone}"),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileCardWidget(
                        title: "Email",
                        value: "${user.userList[0].user![0].email}"),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileCardWidget(
                        title: "User Id",
                        value: "${user.userList[0].user![0].id}"),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileCardWidget(
                        title: "Balance",
                        value: "₹${user.userList[0].user![0].balance}"),
                    SizedBox(
                      height: mheight * 0.06,
                    ),
                    // MaterialButton(
                    //   height: 50,
                    //   minWidth: 250,
                    //   onPressed: () {
                    //     Navigator.of(context)
                    //         .push(MaterialPageRoute(builder: (context) {
                    //       return const ScreenDeleteAccount();
                    //     }));
                    //   },
                    //   shape: const RoundedRectangleBorder(
                    //       side: BorderSide(color: Colors.black),
                    //       borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(20),
                    //           bottomLeft: Radius.circular(40),
                    //           topRight: Radius.circular(40),
                    //           bottomRight: Radius.circular(20))),
                    //   child: const Text(
                    //     'Delete Account',
                    //     style: TextStyle(
                    //         color: textPrimaryColor,
                    //         fontSize: 20,
                    //         letterSpacing: 1,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
        )),
      ),
    );
  }
}
