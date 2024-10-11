import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/generated/assets.dart';

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Get.back(),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.all(4),
                child: Image.asset(
                  matchTextDirection: true,
                  Assets.imgBaseBack,
                  width: 25,
                  height: 25,
                ),
              )
            ],
          )),
    );
  }
}
