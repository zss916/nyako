import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopBg extends StatelessWidget {
  final String url;
  final String? cachePath;
  final String defaultIcon;
  const TopBg(
      {super.key,
      required this.url,
      this.cachePath,
      required this.defaultIcon});

  @override
  Widget build(BuildContext context) {
    return cachePath != null
        ? Image.file(
            File(
              cachePath ?? "",
            ),
            width: 315,
            height: 140,
          )
        : CachedNetworkImage(
            width: 315,
            height: 140,
            matchTextDirection: true,
            placeholder: (
              BuildContext context,
              String url,
            ) =>
                const SizedBox(
                  width: 315,
                  height: 140,
                ),
            errorWidget: (
              BuildContext context,
              String url,
              dynamic error,
            ) =>
                Image.asset(
                  defaultIcon,
                  width: 315,
                  height: 140,
                  matchTextDirection: true,
                ),
            imageUrl: url);
  }
}
