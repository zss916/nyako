import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/services/user_info.dart';

class VipUpOnline extends StatelessWidget {
  const VipUpOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return UserInfo.to.isUserVip
        ? Container(
            width: Get.width,
            height: Get.height,
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              width: Get.width,
              height: 160,
              margin: const EdgeInsetsDirectional.only(top: 100),
              padding:
                  const EdgeInsetsDirectional.only(top: 15, start: 10, end: 10),
              alignment: AlignmentDirectional.center,
              decoration: const BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                      matchTextDirection: true,
                      fit: BoxFit.fitWidth,
                      image: AssetImage(Assets.animaNyakoVipAnimaBg))),
              child: Text(
                Tr.app_vip_up_online.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
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
