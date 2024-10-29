import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
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
    return (seconds < 0)
        ? Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFF8126FF),
                  Color(0xFFFF53DE),
                ]),
                borderRadius: BorderRadiusDirectional.circular(12)),
            width: double.maxFinite,
            margin: const EdgeInsetsDirectional.only(end: 15),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 6),
                  child: Image.asset(
                    Assets.iconCallVideoCard,
                    matchTextDirection: true,
                    width: 24,
                    height: 32,
                  ),
                ),
                Text(
                  Tr.app_time_prop_hint.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                Text(
                  "${seconds}s",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        : Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 30),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: const Color(0x4D000000),
                    borderRadius: BorderRadiusDirectional.circular(40)),
                width: 36,
                height: 36,
                child: UnconstrainedBox(
                  child: Image.asset(
                    Assets.iconCallIc,
                    width: 32,
                    height: 32,
                    matchTextDirection: true,
                  ),
                ),
              ),
              PositionedDirectional(
                  start: 17,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    height: 16,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFE2C55),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      sprintf(" %02i:%02i",
                          [seconds.abs() % 3600 ~/ 60, seconds.abs() % 60]),
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 10),
                    ),
                  ))
            ],
          );
  }
}
