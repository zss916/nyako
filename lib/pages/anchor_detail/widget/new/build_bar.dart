// import 'package:flutter/material.dart';
// import 'package:oliapro/pages/anchor_detail/index.dart';
// import 'package:oliapro/pages/anchor_detail/widget/back.dart';
// import 'package:oliapro/pages/anchor_detail/widget/build_report.dart';
// import 'package:oliapro/pages/anchor_detail/widget/new/build_black.dart';
//
// class BuildBar extends StatelessWidget {
//   final AnchorDetailLogic logic;
//
//   const BuildBar(this.logic, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       backgroundColor: Colors.transparent,
//       pinned: true,
//       leading: Row(
//         children: [
//           Container(
//             margin: const EdgeInsetsDirectional.only(start: 15),
//             child: const Back(),
//           )
//         ],
//       ),
//       actions: [
//         BuildReport(logic.state.anchorId.toString()),
//         BuildBlack(logic),
//       ],
//       elevation: 0,
//     );
//   }
// }
