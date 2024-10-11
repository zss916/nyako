import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/follow_btn2.dart';
import 'package:oliapro/pages/widget/age_and_sex_widget.dart';
import 'package:oliapro/pages/widget/line_state.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_loading.dart';

class Backgarnd extends StatelessWidget {
  final HostDetail data;
  final AnchorDetailLogic logic;

  const Backgarnd(this.data, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return info();
  }

  Widget info() {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      //height: double.maxFinite,
      child: Container(
        width: double.maxFinite,
        //color: Colors.amber,
        margin: const EdgeInsetsDirectional.only(top: 0),
        padding: const EdgeInsetsDirectional.only(start: 0, end: 0, top: 20),
        child: Container(
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 100,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                              bottom: 0, end: 10, top: 0),
                          child: AutoSizeText(
                            (data.nickname ?? "--"),
                            maxLines: 2,
                            maxFontSize: 24,
                            minFontSize: 8,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: data.getUid));
                            AppLoading.toast(Tr.app_base_success.tr);
                          },
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(top: 5),
                            alignment: AlignmentDirectional.centerStart,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadiusDirectional.circular(9)),
                            child: AutoSizeText(
                              "ID: ${data.showId}",
                              maxLines: 1,
                              maxFontSize: 14,
                              minFontSize: 6,
                              style: TextStyle(
                                  fontFamily: AppConstants.fontsRegular,
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          //color: Colors.blue,
                          margin: const EdgeInsetsDirectional.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(end: 5),
                                child: AgeAndSexWidget(data.showBirthday),
                              ),
                              Container(
                                height: 20,
                                //width: 70,
                                alignment: AlignmentDirectional.center,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30)),
                                padding: const EdgeInsetsDirectional.only(
                                    start: 5, end: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LineState(
                                      data.lineState(),
                                      r: 8,
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 3),
                                      child: AutoSizeText(
                                        data.stateStr,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsetsDirectional.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(50),
                            color: Colors.white12,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: ExactAssetImage(
                                    Assets.imgAnchorDefaultAvatar))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: cachedImage(data.showPortrait),
                        ),
                      ),
                      if (data.followed != null)
                        PositionedDirectional(
                            end: 0,
                            bottom: 10,
                            child: GestureDetector(
                              onTap: () => logic.follow(),
                              child: FollowBtn2(isFollowed: data.isFollowed),
                            ))
                    ],
                  )
                ],
              ),
              /* BuildIntro(
                intro: logic.state.host.showIntro,
                margin: 0,
              ),
              SortList(
                logic.state.contributions,
                logic,
                margin: 0,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
