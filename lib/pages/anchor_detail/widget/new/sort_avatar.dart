// import 'package:flutter/material.dart';
// import 'package:oliapro/generated/assets.dart';
// import 'package:oliapro/utils/app_extends.dart';
//
// class SortAvatar extends StatelessWidget {
//   final String url;
//   final int index;
//
//   SortAvatar(this.url, this.index, {super.key});
//
//   final List<String> sorts = [
//     Assets.imgSort1,
//     Assets.imgSort2,
//     Assets.imgSort3
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40,
//       height: 39,
//       foregroundDecoration: BoxDecoration(
//           image: DecorationImage(
//               matchTextDirection: true, image: ExactAssetImage(sorts[index]))),
//       child: Stack(
//         alignment: AlignmentDirectional.center,
//         children: [
//           url == "--"
//               ? Container(
//                   clipBehavior: Clip.hardEdge,
//                   padding: const EdgeInsetsDirectional.all(5),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadiusDirectional.circular(30)),
//                   child: Image.asset(
//                     Assets.imgSortAvatar,
//                     width: 15,
//                     height: 15,
//                     matchTextDirection: false,
//                   ),
//                 )
//               : ClipRRect(
//                   borderRadius: BorderRadiusDirectional.circular(50),
//                   child: cachedImage(url, width: 28, height: 28),
//                 ),
//         ],
//       ),
//     );
//   }
// }
