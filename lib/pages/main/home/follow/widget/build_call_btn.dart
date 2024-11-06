import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/home/index.dart';

class BuildCallBtn extends StatelessWidget {
  final HomeLogic logic;
  final HostDetail item;

  const BuildCallBtn(this.item, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return item.isChat
        ? Row(
            children: [
              GestureDetector(
                onTap: () => logic.startMsg(item.getUid),
                child: Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsetsDirectional.only(end: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(40),
                      gradient: const LinearGradient(colors: [
                        Color(0xFF81E0FF),
                        Color(0xFF4AC6FF),
                      ])),
                  child: UnconstrainedBox(
                    child: Image.asset(
                      Assets.iconToMsgIcon,
                      width: 24,
                      height: 24,
                      matchTextDirection: true,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () => logic.callUp(item),
                  child: Container(
                    width: 60,
                    height: 36,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFF8A29F8),
                          Color(0xFFFC0193),
                        ]),
                        borderRadius: BorderRadiusDirectional.circular(20)),
                    child: Center(
                      child: RepaintBoundary(
                        child: Lottie.asset(
                          Assets.jsonAnimaCall,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ))
            ],
          )
        : const SizedBox.shrink();
  }
}
