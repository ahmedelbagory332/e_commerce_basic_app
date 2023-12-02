import 'package:flutter/material.dart';
import 'package:e_commerce_basic_app/core/constants.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key, required this.increase, required this.decrease});

  final Function(int num) increase;
  final Function(int num) decrease;

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 4),
      child: Row(
        children: <Widget>[
          buildOutlineButton(
              icon: Icons.add,
              press: () {
                setState(() {
                  numOfItems++;
                });
                widget.increase(numOfItems);
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
            child: Text(
              // if our item is less  then 10 then  it shows 01 02 like that
              numOfItems.toString().padLeft(2, "0"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
         
               buildOutlineButton(
            icon: Icons.remove,
            press: () {
              if (numOfItems > 1) {
                setState(() {
                  numOfItems--;
                });
                widget.decrease(numOfItems);
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox buildOutlineButton({required IconData icon, required Function() press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: press,
        child: Icon(icon,color: kMainDarkColor,),
      ),
    );
  }
}
