import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class ConnectingWebp extends StatelessWidget {
  const ConnectingWebp({super.key});

  @override
  Widget build(BuildContext context) {
    return connectWebp();
  }

  Widget connectWebp() {
    return RepaintBoundary(
      child: Image.asset(
        Assets.animaCallConnecting,
        width: 180,
        height: 28,
      ),
    );
  }
}
