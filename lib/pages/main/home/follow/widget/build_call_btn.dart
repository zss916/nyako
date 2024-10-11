import 'package:flutter/material.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/home/index.dart';

class BuildCallBtn extends StatelessWidget {
  final HomeLogic logic;
  final HostDetail item;

  const BuildCallBtn(this.item, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return item.isChat
        ? GestureDetector(
            onTap: () => logic.callUp(item),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      stops: [
                        0.2,
                        1
                      ],
                      colors: [
                        Color(0xFFAC53FB),
                        Color(0xFF7934F0),
                      ]),
                  borderRadius: BorderRadiusDirectional.circular(60)),
              child: Center(
                child: RepaintBoundary(
                  child: Image.asset(
                    Assets.animaCall,
                    width: 24,
                    height: 24,
                    matchTextDirection: true,
                  ),
                ),
              ),
            ))
        : const SizedBox.shrink();
  }
}
