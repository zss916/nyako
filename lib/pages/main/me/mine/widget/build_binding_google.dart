// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nyako/common/language_key.dart';
// import 'package:nyako/generated/assets.dart';
// import 'package:nyako/pages/main/me/mine/index.dart';
//
// class BuildBindingGoogle extends StatelessWidget {
//   final MeLogic logic;
//
//   const BuildBindingGoogle(this.logic, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsetsDirectional.only(start: 15, end: 15, top: 12),
//       child: InkWell(
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//         onTap: () => logic.toBindGoogle(),
//         child: Container(
//           width: double.maxFinite,
//           height: 50,
//           padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
//           alignment: AlignmentDirectional.centerStart,
//           decoration: const BoxDecoration(
//               color: Color(0x14FFFFFF),
//               borderRadius: BorderRadius.all(Radius.circular(16))),
//           child: Row(
//             children: [
//               Container(
//                 margin: const EdgeInsetsDirectional.only(end: 5),
//                 child: Image.asset(
//                   Assets.finalGoogleLogo,
//                   matchTextDirection: true,
//                   width: 20,
//                   height: 20,
//                 ),
//               ),
//               Expanded(
//                   child: Text(
//                 Tr.app_bind_google.tr,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14),
//               )),
//               Container(
//                 margin: const EdgeInsetsDirectional.only(start: 5),
//                 child: Image.asset(
//                   Assets.imgArrowEnd,
//                   matchTextDirection: true,
//                   width: 16,
//                   height: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
