import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_moment_entity.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/utils/app_loading.dart';

class LikeBtn extends StatefulWidget {
  final MomentDetail bean;

  const LikeBtn(
    this.bean, {
    Key? key,
  }) : super(key: key);

  @override
  State<LikeBtn> createState() => _LikeBtnState();
}

class _LikeBtnState extends State<LikeBtn> {
  @override
  Widget build(BuildContext context) {
    return widget.bean.praised == 1
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              priseMoment((widget.bean.momentId ?? 0).toString(), false);
              setState(() {
                widget.bean.praised = 0;
                widget.bean.praiseCount = (widget.bean.praiseCount ?? 0) - 1;
              });
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 6),
                  child: Image.asset(
                    "Assets.imageLikedIcon",
                    width: 22,
                    height: 22,
                    matchTextDirection: true,
                  ),
                ),
                Text((widget.bean.praiseCount ?? 0).toString(),
                    style: const TextStyle(
                        color: Color(0xFFFF3B7A),
                        fontSize: 12,
                        fontWeight: FontWeight.normal))
              ],
            ),
          )
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              priseMoment((widget.bean.momentId ?? 0).toString(), true);
              setState(() {
                widget.bean.praised = 1;
                widget.bean.praiseCount = (widget.bean.praiseCount ?? 0) + 1;
              });
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 6),
                  child: Image.asset(
                    "Assets.imgLikeIcon",
                    width: 22,
                    height: 22,
                    matchTextDirection: true,
                  ),
                ),
                AutoSizeText(
                    widget.bean.praiseCount == 0
                        ? Tr.app_to_like.tr
                        : (widget.bean.praiseCount ?? 0).toString(),
                    maxLines: 1,
                    maxFontSize: 12,
                    minFontSize: 8,
                    style: const TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 12,
                        fontWeight: FontWeight.normal))
              ],
            ));
  }

  void priseMoment(String momentId, bool prise) {
    Http.instance.post<int>(
        prise
            ? NetPath.momentsPraise + momentId
            : NetPath.momentsPraiseCancel + momentId, errCallback: (err) {
      AppLoading.toast(err.message);
    }, showLoading: true);
  }
}
