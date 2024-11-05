import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {
  final Widget child;
  const LoginBtn({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 56,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0x669341FF),
              blurRadius: 15.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
          borderRadius: BorderRadiusDirectional.circular(24),
          color: const Color(0xFF9341FF)),
      margin: const EdgeInsets.only(top: 20, bottom: 10, left: 40, right: 40),
      child: child,
    );
  }
}
