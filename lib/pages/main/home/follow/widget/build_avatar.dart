import 'package:flutter/material.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildAvatar extends StatelessWidget {
  final String portrait;

  const BuildAvatar(this.portrait, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: cachedImage(portrait,
          fit: BoxFit.cover, type: 100, width: 48, height: 48),
    );
  }
}
