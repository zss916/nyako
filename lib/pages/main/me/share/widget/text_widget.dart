import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/widget/text_with_border.dart';

/*Transform.rotate(
angle: -8 * pi / 180,
child: TextWidget(),
)*/

class TextWidget extends StatelessWidget {
  TextWidget({super.key});
  final String title = Tr.app_invite_friend.tr;

  @override
  Widget build(BuildContext context) {
    return StrokeText(
      //text: language_vi[Tr.app_invite_friend] ?? "",
      text: title,
      textStyle: TextStyle(
        fontSize: 36,
        color: const Color(0xFFFFF7D9),
        shadows: const [
          Shadow(
            offset: Offset(0, 2),
            blurRadius: 6.0,
            color: Colors.transparent,
          ),
        ],
        fontFamily: AppConstants.fontsBold,
        fontWeight: FontWeight.bold,
      ),
      strokeColor: Colors.transparent,
      strokeWidth: 3,
    );
  }
}
