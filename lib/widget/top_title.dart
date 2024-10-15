import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final String title;

  const TopTitle(this.title, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: AlignmentDirectional.bottomCenter,
          padding: const EdgeInsets.only(top: 0, bottom: 3, left: 0, right: 0),
          child: AutoSizeText(
            title,
            maxLines: 1,
            maxFontSize: 24,
            minFontSize: 12,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
