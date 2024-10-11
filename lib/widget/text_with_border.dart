import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Color textColor;
  final Color strokeColor;
  final TextStyle? textStyle;

  const StrokeText(
      {super.key,
      required this.text,
      this.strokeWidth = 1,
      this.strokeColor = Colors.black,
      this.textColor = Colors.white,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ).merge(textStyle),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor).merge(textStyle),
        ),
      ],
    );
  }
}
