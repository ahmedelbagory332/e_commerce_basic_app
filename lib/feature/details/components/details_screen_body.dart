
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_basic_app/core/constants.dart';
import 'cart_counter.dart';
import 'description.dart';

class DetailsScreenBody extends StatelessWidget {
  final ProductsModel product;

  const DetailsScreenBody({super.key, required this.product});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                            child: Expanded(
                              child: Hero(
                                tag: "${product.id}",
                                child: Flexible(
                                  child: CachedNetworkImage(
                                    width: MediaQuery.of(context).size.width,
                                    placeholder: (context, url) => Image.asset(
                                      "assets/images/place_holder.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                    imageUrl: product.image??"",
                                    errorWidget: (context, url, error) => Image.asset(
                                      "assets/images/place_holder.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: kDefaultPaddin / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product.title??"",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "  \$${product.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultPaddin / 2),
                        Description(product: product),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: kDefaultPaddin / 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CartCounter(),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: kMainDarkColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: () {},
                    child: Text(
                      "ADD TO CART".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPaddin / 2),
      ],
    );
  }
}
