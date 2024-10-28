import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class ChatBackgrand extends StatelessWidget {
  final String path;

  const ChatBackgrand(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (path == "--" || path == "")
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.iconAnchorDefault),
                  fit: BoxFit.cover))
          : BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(path),
                fit: BoxFit.cover,
              ),
            ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
