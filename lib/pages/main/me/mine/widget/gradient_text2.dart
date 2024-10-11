import 'package:flutter/material.dart';

class GradientText2 extends StatelessWidget {
  const GradientText2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Expire on 2023.06.28",
      style: TextStyle(
          fontSize: 15,
          foreground: Paint()
            ..shader = const LinearGradient(colors: [
              Color(0xFFFF741A),
              Color(0xFFFF17D6),
            ]).createShader(const Rect.fromLTWH(0, 0, 300, 0)),
          fontWeight: FontWeight.w500),
    );
  }
}
