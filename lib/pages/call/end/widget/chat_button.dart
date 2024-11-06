// import 'package:flutter/material.dart';
// import 'package:nyako/generated/assets.dart';
//
// class ChatButton extends StatelessWidget {
//   final bool isCall;
//
//   const ChatButton({super.key, required this.isCall});
//
//   @override
//   Widget build(BuildContext context) {
//     return isCall
//         ? Container(
//             width: 54,
//             height: 54,
//             decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                     begin: AlignmentDirectional.topStart,
//                     end: AlignmentDirectional.bottomEnd,
//                     stops: [
//                       0.2,
//                       1
//                     ],
//                     colors: [
//                       Color(0xFFAC53FB),
//                       Color(0xFF7934F0),
//                     ]),
//                 borderRadius: BorderRadiusDirectional.circular(60)),
//             child: Center(
//               child: RepaintBoundary(
//                 child: Image.asset(
//                   Assets.animaCall,
//                   width: 30,
//                   height: 30,
//                   matchTextDirection: true,
//                 ),
//               ),
//             ),
//           )
//         : Image.asset(
//             Assets.imgHotMsgIcon,
//             width: 54,
//             height: 54,
//             matchTextDirection: true,
//           );
//   }
// }
