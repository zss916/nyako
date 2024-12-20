import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetLogoImage extends StatelessWidget {
  final String path;
  const NetLogoImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        height: 90,
        width: 90,
        fit: BoxFit.cover,
        matchTextDirection: true,
        placeholder: (
          BuildContext context,
          String url,
        ) =>
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
                color: const Color(0xFF9341FF),
              ),
            ),
        errorWidget: (
          BuildContext context,
          String url,
          dynamic error,
        ) =>
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
                color: const Color(0xFF9341FF),
              ),
            ),
        imageUrl: path);
  }
}
