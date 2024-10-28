import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/generated/assets.dart';

class ConnectingWebp extends StatelessWidget {
  const ConnectingWebp({super.key});

  @override
  Widget build(BuildContext context) {
    return connectWebp();
  }

  Widget connectWebp() {
    return RepaintBoundary(
      child: Lottie.asset(
        Assets.jsonAnimaConnecting,
        width: 100,
        height: 60,
      ),
    );
  }
}
