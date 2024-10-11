import 'package:flutter/material.dart';
import 'package:oliapro/common/app_colors.dart';

class LoginBtn extends StatelessWidget {
  final Widget child;
  const LoginBtn({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(30),
          gradient: AppColors.btnGradient),
      margin: const EdgeInsets.only(top: 20, bottom: 10, left: 40, right: 40),
      child: child,
    );
  }
}
