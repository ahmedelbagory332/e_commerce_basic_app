import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:e_commerce_basic_app/feature/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:share_plus/share_plus.dart';

import 'components/settings_item.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: kMainDarkColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kMainDarkColor,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            kMainDarkColor.withAlpha(700),
                            kMainDarkColor,
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 18.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    "assets/images/place_holder.jpg",
                                    height: 55,
                                    width: 55,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Admin",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "admin@admin.com",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () async {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.edit,
                                        color: kMainDarkColor,
                                      ),
                                      const SizedBox(height: 1),
                                      Container(
                                        color: Colors.white,
                                        width: 20,
                                        height: 1,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SettingsItem(
                onTap: () {
                  PersistentNavBarNavigator
                      .pushNewScreen(
                    context,
                    screen: const WalletScreen(),
                    withNavBar: false,
                    pageTransitionAnimation:
                    PageTransitionAnimation
                        .cupertino,
                  );
                },
                text: 'Your Wallet',
                icon: "assets/images/wallet.svg",
              ),
              SettingsItem(
                onTap: () {},
                text: 'Customer Support',
                icon: "assets/images/support.svg",
              ),
              SettingsItem(
                onTap: () {
                  Share.share('https://play.google.com/store/apps');
                },
                text: "Share App",
                icon: "assets/images/share.svg",
                // enabled: false,
              ),
              SettingsItem(
                onTap: () {},
                text: "Log Out",
                icon: "assets/images/logout.svg",
                logOut: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
