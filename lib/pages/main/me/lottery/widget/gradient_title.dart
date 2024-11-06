import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';

class GradientTitle extends StatelessWidget {
  final String title;

  const GradientTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
            colors: [Color(0xFFFF741A), Color(0xFFFF17D6)]).createShader(rect);
      },
      blendMode: BlendMode.srcATop,
      child: AutoSizeText(
        title,
        maxLines: 2,
        textAlign: TextAlign.center,
        maxFontSize: 24,
        minFontSize: 7,
        style: TextStyle(
            color: Colors.white,
            fontFamily: AppConstants.fontsRegular,
            fontSize: 24),
      ),
    );
  }
}
