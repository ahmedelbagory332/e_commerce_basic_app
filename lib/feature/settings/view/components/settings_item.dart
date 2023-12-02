import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SettingsItem extends StatelessWidget {
  final String text;
  final String icon;
  final bool logOut;
  final void Function() onTap;

  const SettingsItem({Key? key, required this.text, required this.icon, this.logOut = false, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 15, bottom: 15),
          child: Row(
            children: [
              SvgPicture.asset(icon,color: logOut ? Colors.red : Colors.black),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(
                    color: logOut ? Colors.red : Colors.black, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if(!logOut)
                    SvgPicture.asset(
                      "assets/images/arrow_next.svg",
                      matchTextDirection: true,
                      color: Colors.black,

                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
