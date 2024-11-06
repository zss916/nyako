import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/generated/assets.dart';

class AgeAndSexWidget extends StatelessWidget {
  final String age;

  const AgeAndSexWidget(this.age, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 20,
      alignment: Alignment.center,
      margin: const EdgeInsetsDirectional.only(start: 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(5)),
          color: Color(0x1AFF3881)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 1),
            child: Image.asset(
              Assets.iconSmallWoman,
              width: 14,
              height: 14,
              matchTextDirection: true,
            ),
          ),
          Text(
            age,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color(0xFFFF3881),
                fontSize: 13,
                fontFamily: AppConstants.fontsRegular,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
