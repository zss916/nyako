import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_confirm.dart';
import 'package:oliapro/entities/app_host_match_limit_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_loading.dart';

class Follow extends StatefulWidget {
  final HostMatchLimitEntityAnchor anchor;

  const Follow(this.anchor, {super.key});

  @override
  State<Follow> createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          if (widget.anchor.followed == 1) {
            Future.delayed(Duration.zero, () {
              Get.dialog(AppDialogConfirm(
                title: Tr.app_details_tip.tr,
                showIcon: false,
                h: 260,
                callback: (i) {
                  handleFollow();
                },
              ));
            });
          } else {
            handleFollow();
          }
        },
        child: widget.anchor.followed == 1
            ? Image.asset(
                Assets.imgFollowed,
                width: 28,
                height: 20,
                matchTextDirection: true,
              )
            : Image.asset(
                Assets.imgFollow,
                width: 28,
                height: 20,
                matchTextDirection: true,
              ),
      );
    });
  }

  ///关注
  void handleFollow() {
    Http.instance.post<int>(NetPath.followUpApi + (widget.anchor.getUid),
        errCallback: (err) {
      AppLoading.toast(err.message);
    }, showLoading: true).then((value) {
      setState(() {
        widget.anchor.followed = value;
        AppEventBus.eventBus.fire(FollowEvent(
            anchorId: (widget.anchor.getUid), isFollowed: (value == 1)));
      });
    });
  }
}
