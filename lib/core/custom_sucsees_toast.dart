
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oktoast/oktoast.dart';


class CustomSuccessToastWidget extends StatelessWidget {
  CustomSuccessToastWidget({super.key, required this.toastText});

  String toastText;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 46,
        child: Container(
          height: 46,
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.green,
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
                    SvgPicture.asset(
                      "assets/images/done-md-light.svg",
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      width: 300,
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.white),
                        child: Text(
                          toastText,
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

showCustomSuccessToast(String toastText) {
  showToastWidget(
    CustomSuccessToastWidget(toastText: toastText),
    dismissOtherToast: true,
    handleTouch: true,
    position: ToastPosition.top,
    duration: const Duration(seconds: 3),
  );
}
