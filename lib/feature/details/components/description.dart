import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_basic_app/core/constants.dart';

class Description extends StatelessWidget {


  final ProductsModel product;

  const Description({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
              ),
            )),
        const SizedBox(height: kDefaultPaddin / 5),
        Text(
          product.description??"",
          style: const TextStyle(height: 1.5),
        ),
      ],
    );
  }
}
