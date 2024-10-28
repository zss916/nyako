import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/dialogs/dialog_confirm.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_some_extension.dart';

import '../common/language_key.dart';
import '../entities/app_host_entity.dart';

class UserWidget extends StatelessWidget {
  final HostDetail? detail;
  final Function callBack;
  final bool? canJumpHostDetail;
  final bool? showHostStatus;
  final double? nameMaxWidth;

  const UserWidget(
      {super.key,
      required this.detail,
      required this.callBack,
      this.canJumpHostDetail = false,
      this.showHostStatus = true,
      this.nameMaxWidth = 85});

  @override
  Widget build(BuildContext context) {
    return detail == null
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () async {
              if (canJumpHostDetail!) {
                Get.back();
                ARoutes.toAnchorDetail(detail!.userId);
              }
            },
            child: Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 15,
                ),
                padding: const EdgeInsetsDirectional.only(
                    top: 5, bottom: 5, start: 7, end: 10),
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserPortraitWidget(
                      detail: detail!,
                      height: 35,
                      showHostStatus: showHostStatus,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: nameMaxWidth!,
                          ),
                          child: Text(
                            (detail!.nickname ?? "").replaceNumByStar(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "ID:${(detail!.username ?? "--")}",
                          style: TextStyle(
                              color: const Color(0xB3FFFFFF),
                              fontFamily: AppConstants.fontsRegular,
                              fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (detail?.followed != null)
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            if (detail!.followed == 1) {
                              Future.delayed(Duration.zero, () {
                                Get.dialog(AppDialogConfirm(
                                  title: "",
                                  content: Tr.app_details_tip.tr,
                                  showIcon: true,
                                  callback: (i) {
                                    ///取消关注
                                    callBack();
                                  },
                                ));
                              });
                            } else {
                              ///关注
                              callBack();
                            }
                          },
                          child: detail!.followed == 1
                              ? Container(
                                  width: 28,
                                  height: 28,
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF5F4F6),
                                      borderRadius:
                                          BorderRadiusDirectional.circular(30)),
                                  child: UnconstrainedBox(
                                    child: Image.asset(
                                      Assets.iconFollowed,
                                      matchTextDirection: true,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 28,
                                  height: 28,
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF9341FF),
                                      borderRadius:
                                          BorderRadiusDirectional.circular(30)),
                                  child: UnconstrainedBox(
                                    child: Image.asset(
                                      Assets.iconFollow,
                                      matchTextDirection: true,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                        );
                      })
                  ],
                )),
          );
  }
}

class UserPortraitWidget extends StatelessWidget {
  final HostDetail detail;
  final double? height;
  final bool? showHostStatus;
  const UserPortraitWidget(
      {super.key,
      required this.detail,
      this.height = 54,
      this.showHostStatus = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      padding: const EdgeInsetsDirectional.all(3),
      decoration: BoxDecoration(
          image: const DecorationImage(
              fit: BoxFit.cover,
              matchTextDirection: true,
              image: ExactAssetImage(Assets.iconAnchorDefault)),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 1, color: Colors.transparent)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: cachedImage(detail.showPortrait),
      ),
    );
  }
}
