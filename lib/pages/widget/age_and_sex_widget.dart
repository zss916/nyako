import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

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
          borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
          color: Color(0xFFFF2279)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 1),
            child: Image.asset(
              Assets.imgSmallWoman,
              width: 14,
              height: 14,
              matchTextDirection: true,
            ),
          ),
          Text(
            age,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          )
        ],
      ),
    );
  }
}
