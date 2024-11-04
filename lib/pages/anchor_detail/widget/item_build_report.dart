// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:oliapro/common/language_key.dart';
// import 'package:oliapro/entities/app_moment_entity.dart';
// import 'package:oliapro/generated/assets.dart';
// import 'package:oliapro/routes/a_routes.dart';
// import 'package:oliapro/utils/app_event_bus.dart';
//
// class ItemBuildReport extends StatelessWidget {
//   final MomentDetail item;
//
//   const ItemBuildReport(this.item, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton.icon(
//         onPressed: () => ARoutes.toReport(
//             uid: item.userId ?? "",
//             type: ReportEnum.anchorDetailMoment.index.toString(),
//             channelID: item.momentId),
//         icon: Image.asset(
//           Assets.imgReportIcon,
//           matchTextDirection: true,
//           width: 22,
//           height: 22,
//         ),
//         label: Text(Tr.app_report_title.tr,
//             style: const TextStyle(
//                 color: Color(0xFF828282),
//                 fontSize: 13,
//                 fontWeight: FontWeight.normal)));
//   }
// }
