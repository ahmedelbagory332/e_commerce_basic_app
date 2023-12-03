import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oktoast/oktoast.dart';


class CustomErrorToastWidget extends StatelessWidget {
  CustomErrorToastWidget({super.key, required this.toastText});

  String toastText;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, -2),
                color: const Color(0xFF000000).withOpacity(.12),
                spreadRadius: 0,
              ),
              BoxShadow(
                blurRadius: 5,
                offset: const Offset(0, -2),
                color: const Color(0xFF000000).withOpacity(.16),
                spreadRadius: 0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            toastText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

showCustomErrorToast(String toastText) {
  showToastWidget(
    CustomErrorToastWidget(toastText: toastText),
    dismissOtherToast: true,
    handleTouch: true,
    position: ToastPosition.top,
    duration: const Duration(seconds: 3),
  );
}
