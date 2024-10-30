import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class TopBg extends StatelessWidget {
  final String url;
  final String? cachePath;
  const TopBg({super.key, required this.url, this.cachePath});

  @override
  Widget build(BuildContext context) {
    return cachePath != null
        ? Image.file(
            File(
              cachePath ?? "",
            ),
            width: 315,
            height: 146,
          )
        : CachedNetworkImage(
            width: 315,
            height: 146,
            matchTextDirection: true,
            placeholder: (
              BuildContext context,
              String url,
            ) =>
                const SizedBox(
                  width: 315,
                  height: 146,
                ),
            errorWidget: (
              BuildContext context,
              String url,
              dynamic error,
            ) =>
                Image.asset(
                  Assets.rewardBg3,
                  width: 315,
                  height: 146,
                  matchTextDirection: true,
                ),
            imageUrl: url);
  }
}
