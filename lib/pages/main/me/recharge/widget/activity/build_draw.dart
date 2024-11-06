// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nyako/common/language_key.dart';
// import 'package:nyako/generated/assets.dart';
//
// class BuildDraw extends StatelessWidget {
//   const BuildDraw({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: double.maxFinite,
//       margin: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 10),
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               matchTextDirection: true,
//               image: ExactAssetImage(Assets.imgRechargeBannerBg))),
//       child: Row(
//         children: [
//           Image.asset(
//             Assets.imgRechargeTurn,
//             width: 90,
//             height: 90,
//             matchTextDirection: true,
//           ),
//           Expanded(child: buildTip())
//         ],
//       ),
//     );
//   }
//
//   Widget buildTip() {
//     return Container(
//       //color: Colors.green,
//       width: double.maxFinite,
//       height: double.maxFinite,
//       alignment: AlignmentDirectional.center,
//       margin: const EdgeInsets.only(top: 0),
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       child: Text(
//         Tr.app_lucky_draw_tip.tr,
//         textAlign: TextAlign.start,
//         style: const TextStyle(
//             color: Color(0xFFC3A0FF),
//             fontSize: 12,
//             fontWeight: FontWeight.w400),
//       ),
//     );
//   }
// }
