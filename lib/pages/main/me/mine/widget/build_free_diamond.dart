// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:oliapro/common/language_key.dart';
// import 'package:oliapro/generated/assets.dart';
// import 'package:oliapro/pages/main/me/mine/index.dart';
// import 'package:oliapro/utils/app_extends.dart';
// import 'package:oliapro/utils/app_some_extension.dart';
// import 'package:oliapro/widget/app_click_widget2.dart';
// import 'package:oliapro/widget/semantics/label.dart';
// import 'package:oliapro/widget/semantics/semantics_widget.dart';
//
// class BuildFreeDiamond extends StatefulWidget {
//   final MeLogic logic;
//
//   const BuildFreeDiamond(this.logic, {super.key});
//
//   @override
//   State<BuildFreeDiamond> createState() => _BuildGiftState();
// }
//
// class _BuildGiftState extends State<BuildFreeDiamond> with DragInterface2 {
//   String getTitle = Tr.app_get_vip_diamonds2.tr;
//
//   @override
//   Widget build(BuildContext context) {
//     return buildDrag(widget.logic);
//   }
//
//   Widget buildDrag(MeLogic logic) {
//     return logic.state.isVip
//         ? const SizedBox.shrink()
//         : Obx(() {
//             return AnimatedPositionedDirectional(
//               start: Get.locale?.languageCode != "ar"
//                   ? null
//                   : -moveOffset.value.dx,
//               end: Get.locale?.languageCode != "ar"
//                   ? -moveOffset.value.dx
//                   : null,
//               bottom: moveOffset.value.dy,
//               duration: const Duration(milliseconds: 10),
//               child: buildGift().onLabel(label: SemanticsLabel.signIn),
//             );
//           });
//   }
//
//   Widget buildGift() {
//     return AppClickWidget2(
//       onTap: () {
//         widget.logic.getFreeDiamond();
//         // toSignDialog();
//       },
//       onHorizontalDragStart: (details) {
//         onDragStart(details.localPosition);
//       },
//       onHorizontalDragUpdate: (details) {
//         onDragMoveUpdate(details.localPosition);
//       },
//       onHorizontalDragEnd: (details) {
//         onDragEnd(
//             const Size(44, 4),
//             Size(Get.width, Get.height),
//             EdgeInsetsDirectional.only(
//                 top: Get.statusBarHeight + 50,
//                 start: Get.isAr ? 30 : 30,
//                 end: Get.isAr ? 30 : 30,
//                 bottom: Get.bottomBarHeight + 60));
//       },
//       child: Container(
//         //color: Colors.red,
//         margin: const EdgeInsetsDirectional.only(bottom: 0, end: 40, start: 0),
//         child: Stack(
//           alignment: AlignmentDirectional.bottomCenter,
//           children: [
//             Container(
//               margin: const EdgeInsetsDirectional.only(bottom: 5),
//               child: RepaintBoundary(
//                 child: Image.asset(
//                   Assets.animaFreeDiamondIcon,
//                   matchTextDirection: true,
//                   width: Get.isVi ? 75 : 66,
//                   height: Get.isVi ? 75 : 66,
//                 ),
//               ),
//             ),
//             PositionedDirectional(
//                 bottom: 10,
//                 child: Container(
//                   width: Get.isVi ? 75 : 66,
//                   padding: EdgeInsetsDirectional.symmetric(
//                       horizontal: Get.isVi ? 5 : (Get.isTr ? 2 : 0)),
//                   alignment: AlignmentDirectional.center,
//                   child: AutoSizeText(
//                     Tr.app_vip_free.tr,
//                     /* "VIP bilgileri",*/
//                     maxFontSize: 12,
//                     minFontSize: 6,
//                     maxLines: 1,
//                     style: const TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
