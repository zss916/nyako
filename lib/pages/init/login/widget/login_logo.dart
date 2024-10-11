import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oliapro/generated/assets.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 20),
          child: Image.asset(
            Assets.imgLoginBg,
            width: double.maxFinite,
            matchTextDirection: true,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(top: 50.h, bottom: 20.h),
              child: Image.asset(
                Assets.imgAppLogo,
                height: 95,
                width: 95,
                matchTextDirection: false,
              ),
            ),
            Image.asset(
              Assets.imgMira,
              scale: 3,
              matchTextDirection: false,
            ),

            /*const Text(AppConstants.appName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),*/
          ],
        ),
      ],
    );
  }
}
