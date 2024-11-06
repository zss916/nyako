import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';

class ShortBaseButton extends StatelessWidget {
  final String title;

  final bool isSave;

  const ShortBaseButton(this.title, {super.key, required this.isSave});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        UnconstrainedBox(
          child: Container(
            height: 52,
            alignment: Alignment.center,
            margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
            padding: const EdgeInsetsDirectional.only(
                start: 30, end: 30, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color:
                    isSave ? const Color(0xFF9341FF) : const Color(0xFFF1F0F2),
                borderRadius: BorderRadiusDirectional.circular(80)),
            child: AutoSizeText(
              title,
              maxFontSize: 16,
              minFontSize: 8,
              maxLines: 1,
              style: TextStyle(
                  color: isSave ? Colors.white : const Color(0xFFBCB6C4),
                  fontSize: 16,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
