import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';

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
        style: TextStyle(
          fontFamily: AppConstants.fontsRegular,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}
