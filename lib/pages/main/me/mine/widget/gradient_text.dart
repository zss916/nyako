import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String title;

  const GradientText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(colors: [
          Color(0xFFFF741A),
          Color(0xFFFF17D6),
          Color(0xFFC694FF)
        ]).createShader(rect);
      },
      blendMode: BlendMode.srcATop,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }
}
