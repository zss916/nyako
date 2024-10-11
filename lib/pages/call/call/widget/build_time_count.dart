import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:sprintf/sprintf.dart';

class BuildTimeCount extends StatelessWidget {
  final int seconds;

  const BuildTimeCount(this.seconds, {super.key});

  @override
  Widget build(BuildContext context) {
    return callCountTime(seconds);
  }

  ///聊天计时器
  Widget callCountTime(int seconds) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      height: 26,
      decoration: BoxDecoration(
          color: const Color(0xFFFE2C55),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 3),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: seconds < 0,
                child: Image.asset(
                  Assets.imgCallCard,
                  matchTextDirection: true,
                  width: 26,
                  height: 18,
                ),
              ),
              Text(
                sprintf(" %02i:%02i",
                    [seconds.abs() % 3600 ~/ 60, seconds.abs() % 60]),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
