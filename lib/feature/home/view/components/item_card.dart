import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce_basic_app/core/constants.dart';

class ItemCard extends StatelessWidget {
  final ProductsModel product;
  final Function() press;

  const ItemCard({super.key, required this.product, required this.press});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPaddin / 2, vertical: kDefaultPaddin / 4),
      child: GestureDetector(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(kDefaultPaddin / 2),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: kTextColor,
                spreadRadius: 0.1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: "${product.id}",
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPaddin / 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        product.title??"",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/Star.svg",
                              color: const Color(0xFFEEA939),
                              height: 10,
                            ),

                            Text(
                              " ${product.rating?.rate??0}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "\$ ${product.price}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
