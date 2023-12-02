import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:flutter/material.dart';


class WidgetError extends StatelessWidget {
  const WidgetError(
      {super.key,
        this.refresh,
        this.title = "حدث خطأ ما",
        required this.subTitle});

  final void Function()? refresh;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // width: double.infinity,
        color: Colors.transparent,
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: greyscale900),
            ),
            const SizedBox(height: 20),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: greyscale900),
            ),
            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: refresh,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Refresh",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kMainDarkColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.refresh,
                        color: kMainDarkColor,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
