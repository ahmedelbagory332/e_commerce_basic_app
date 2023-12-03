import 'package:e_commerce_basic_app/feature/home/view/home_screen.dart';
import 'package:e_commerce_basic_app/feature/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CardAlertDialog extends StatelessWidget {
  const CardAlertDialog({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
      return false;
    },
      child: AlertDialog(
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 80.0,
                top: -90.0,
                child: Image.asset(
                  'assets/icons/checked.png',
                  height: 90,
                  width: 90,
                ),
              ),
               Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Your card was accepted',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffaf4c4c),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'You can now use your card to make payments, Thank you',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kMainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: Size(MediaQuery.of(context).size.width / 1.12, 55),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => MainScreen()),
                                (route) => route.isFirst);
                      },
                      child: Text(
                        'Close'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          )),
    );
  }
}