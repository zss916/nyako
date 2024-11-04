import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class AgeAndSex extends StatelessWidget {
  final String age;

  const AgeAndSex(this.age, {Key? key}) : super(key: key);

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
            margin: const EdgeInsetsDirectional.only(end: 2),
            child: Image.asset(
              Assets.iconSmallWoman,
              width: 11,
              height: 15,
              matchTextDirection: true,
            ),
          ),
          Text(
            age,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
