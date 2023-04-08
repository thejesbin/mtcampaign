import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtcampaign/controller/settings_controller.dart';
import 'package:mtcampaign/controller/user_controller.dart';
import 'package:mtcampaign/core/constants.dart';
import 'package:mtcampaign/view/screen_profile/screen_profile.dart';
import 'package:mtcampaign/view/screen_refer/screen_refer.dart';
import 'package:mtcampaign/view/screen_referrals/screen_referrals.dart';
import 'package:mtcampaign/view/screen_transactions.dart/screen_transactions.dart';
import 'package:mtcampaign/view/screen_wallet/screen_wallet.dart';
import 'package:mtcampaign/view/splash_screen/splash_screen.dart';
import 'package:mtcampaign/view/widgets/navigation_content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var settings = Get.put(SettingsController());
    var user = Get.put(UserController());
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Drawer(
      width: mwidth * 0.65,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                appName,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 0.2,
                width: double.infinity,
                color: Colors.black,
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () => Get.to(() => ScreenProfile()),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/profile.png"),
                ),
              ),
              Obx(
                () => Center(
                  child: Text(
                    "Hi ${user.userList[0].user![0].name}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "REFER & EARN",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () => Get.to(() => ScreenRefer()),
                child: const NavigationContentWidget(
                  title: "Refer Link",
                  icon: Icons.share_outlined,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.to(() => ScreenReferrals()),
                child: const NavigationContentWidget(
                  title: "My Refferals",
                  icon: Icons.group_add_outlined,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "WITHDRAW & TRANSACTION",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () => Get.to(() => ScreenProfile()),
                child: const NavigationContentWidget(
                  title: "Profile",
                  icon: Icons.account_circle_outlined,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.to(() => ScreenWallet()),
                child: const NavigationContentWidget(
                  title: "Withdrawal",
                  icon: Icons.account_balance_outlined,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenTransactions())),
                child: const NavigationContentWidget(
                  title: "All Transactions",
                  icon: Icons.track_changes,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "CHAT & SUPPORT",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  var url = Uri.parse("${settings.settingsList[0].tgChannel}");
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: const NavigationContentWidget(
                  title: "Telegram",
                  icon: Icons.telegram_outlined,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  var url = Uri.parse("${settings.settingsList[0].tgSupport}");
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: const NavigationContentWidget(
                  title: "Support",
                  icon: Icons.support_agent_outlined,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.clear();
                  Get.offAll(() => ScreenSplash());
                },
                child: const NavigationContentWidget(
                  title: "Logout",
                  icon: Icons.logout_outlined,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
