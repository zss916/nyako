import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_moment_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildMoreReport extends StatelessWidget {
  final MomentDetail item;

  const BuildMoreReport(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () => ARoutes.toReport(
            uid: item.userId ?? "", type: "1", channelID: item.momentId),
        icon: Image.asset(
          Assets.imgReportIcon,
          matchTextDirection: true,
          width: 20,
          height: 20,
        ),
        label: Text(Tr.app_report_title.tr,
            style: const TextStyle(
                color: Color(0xFFB7B7B7),
                fontSize: 12,
                fontWeight: FontWeight.normal)));
  }
}
