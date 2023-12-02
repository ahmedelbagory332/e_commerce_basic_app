import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:e_commerce_basic_app/feature/details/components/details_screen_body.dart';
import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class DetailsScreen extends StatelessWidget {
  final ProductsModel product;

  const DetailsScreen({super.key, required this.product});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: DetailsScreenBody(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kMainColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: const <Widget>[
        SizedBox(width: kDefaultPaddin)
      ],
    );
  }
}
