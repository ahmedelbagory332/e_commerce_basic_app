import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_basic_app/feature/notification/view/norification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String checkTimeAm() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('a').format(now);

    if (formattedTime == 'AM') {
      return "Hello ! Good Morning 👋";
    } else {
      return "Hello ! Good evening 👋";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          checkTimeAm(),
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: kTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/notification.svg",
                        color: kTextColor,
                      ),
                      onPressed: () {
                        PersistentNavBarNavigator
                            .pushNewScreen(
                          context,
                          screen: const NotificationScreen(),
                          withNavBar: false,
                          pageTransitionAnimation:
                          PageTransitionAnimation
                              .cupertino,
                        );
                      },
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("notification")
                            .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        if (snapshot.hasError) {
                          return const SizedBox();
                        }
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const SizedBox();
                        }
                        return snapshot.data!.docs[0]["new_notification"]==true?
                          Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ):const SizedBox();
                      }
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
