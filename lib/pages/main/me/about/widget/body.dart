import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/about/index.dart';
import 'package:nyako/services/app_info_service.dart';

class AboutBody extends StatelessWidget {
  final AboutLogic logic;

  const AboutBody(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 10, start: 15, end: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ClipRRect(
              borderRadius:
                  const BorderRadiusDirectional.all(Radius.circular(0)),
              child: Image.asset(
                Assets.iconSmallLogo,
                width: 105,
                height: 105,
                matchTextDirection: true,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(
              Assets.iconNyako,
              scale: 3,
              color: Colors.black,
              matchTextDirection: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 20),
            child: Text(
              AppInfoService.to.version,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 20),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            //padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                buildCell(logic.listData[0]),
                const Divider(
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Color(0xFFE3E3E3),
                ),
                buildCell(logic.listData[1]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCell(Map data) {
    return InkWell(
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(14), bottom: Radius.circular(14)),
      onTap: () {
        if (data['type'] == 'privacy') {
          logic.toPolicy();
        } else {
          logic.toAgreement();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data['title']!,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Image.asset(
              Assets.iconNext,
              width: 20,
              height: 20,
              matchTextDirection: true,
            )
          ],
        ),
      ),
    );
  }
}
