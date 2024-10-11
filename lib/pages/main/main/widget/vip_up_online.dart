import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/services/user_info.dart';

class VipUpOnline extends StatelessWidget {
  const VipUpOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return UserInfo.to.isUserVip
        ? Container(
            width: Get.width,
            height: Get.height,
            alignment: AlignmentDirectional.topCenter,
            /*decoration: const BoxDecoration(
              color: Colors.black54,
            ),*/
            child: Container(
              width: 332,
              height: 86,
              margin: const EdgeInsetsDirectional.only(top: 50),
              alignment: AlignmentDirectional.bottomCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      matchTextDirection: true,
                      image: AssetImage(Assets.animaVipAnimaBg))),
              child: Container(
                width: 332,
                padding: const EdgeInsetsDirectional.only(
                    bottom: 12, start: 10, end: 10),
                child: const VipContent(),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

class VipContent extends StatefulWidget {
  const VipContent({super.key});

  @override
  State<VipContent> createState() => _VipContentState();
}

class _VipContentState extends State<VipContent> {
  bool isShow = false;
  final String title = Tr.app_vip_up_online.tr;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          isShow = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShow
        ? AutoSizeText(
            title,
            maxFontSize: 14,
            minFontSize: 6,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xFFF0DF90),
                fontWeight: FontWeight.w400,
                fontSize: 14),
          )
        : const SizedBox.shrink();
  }
}
