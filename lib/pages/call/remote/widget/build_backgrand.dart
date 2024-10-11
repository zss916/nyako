import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class BuildBackgrand extends StatelessWidget {
  final String portrait;
  const BuildBackgrand(this.portrait, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(Assets.imgAnchorBigDefaultBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: portrait != ""
            ? BoxDecoration(
                image: DecorationImage(
                  //image: ExtendedNetworkImageProvider(portrait),
                  image: CachedNetworkImageProvider(portrait),
                  fit: BoxFit.cover,
                ),
              )
            : const BoxDecoration(),
        child: ClipRRect(
          child: BackdropFilter(
            //背景滤镜
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
