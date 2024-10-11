import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 120, bottom: 10),
          child: Image.asset(
            Assets.imgAppLogo,
            width: 95,
            height: 95,
            matchTextDirection: false,
          ),
        ),
        Image.asset(
          Assets.imgMira,
          scale: 3,
          matchTextDirection: false,
        ),
        /*  const Text(
          AppConstants.appName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        )*/
      ],
    );
  }
}
