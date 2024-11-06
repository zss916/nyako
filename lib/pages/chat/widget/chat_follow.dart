// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nyako/common/language_key.dart';
// import 'package:nyako/dialogs/dialog_confirm.dart';
// import 'package:nyako/entities/app_host_entity.dart';
// import 'package:nyako/generated/assets.dart';
// import 'package:nyako/http/api/index.dart';
// import 'package:nyako/utils/app_event_bus.dart';
//
// class ChatFollow extends StatefulWidget {
//   final HostDetail anchor;
//
//   const ChatFollow(this.anchor, {super.key});
//
//   @override
//   State<ChatFollow> createState() => _FollowState();
// }
//
// class _FollowState extends State<ChatFollow> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       return GestureDetector(
//         onTap: () {
//           if (widget.anchor.followed == 1) {
//             Future.delayed(Duration.zero, () {
//               Get.dialog(AppDialogConfirm(
//                 title: Tr.app_details_tip.tr,
//                 showIcon: false,
//                 h: 260,
//                 callback: (i) {
//                   handleFollow();
//                 },
//               ));
//             });
//           } else {
//             handleFollow();
//           }
//         },
//         child: widget.anchor.followed == 1
//             ? const SizedBox.shrink()
//             : Image.asset(
//                 Assets.imgFollow,
//                 width: 40,
//                 height: 30,
//                 matchTextDirection: true,
//               ),
//       );
//     });
//   }
//
//   ///关注
//   void handleFollow() {
//     ProfileAPI.follow(anchorId: widget.anchor.getUid).then((value) {
//       if (mounted) {
//         setState(() {
//           widget.anchor.followed = value;
//           AppEventBus.eventBus.fire(FollowEvent(
//               anchorId: widget.anchor.getUid, isFollowed: value == 1));
//         });
//       }
//     });
//   }
// }
