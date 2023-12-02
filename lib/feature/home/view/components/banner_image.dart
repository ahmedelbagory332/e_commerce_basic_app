
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  final String imageUrl;

  const BannerImage(
      {super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              top: 0,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  "assets/images/place_holder.jpg",
                  fit: BoxFit.fill,
                ),
                imageUrl: imageUrl??"",
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/place_holder.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
