import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_tags.dart';
import 'package:oliapro/pages/anchor_detail/widget/state_widget.dart';
import 'package:oliapro/pages/widget/age_and_sex.dart';
import 'package:oliapro/pages/widget/line_state.dart';
import 'package:oliapro/utils/app_extends.dart';

class HeaderWidget extends StatelessWidget {
  final AnchorDetailLogic logic;

  const HeaderWidget(this.logic, {super.key});

  final double h = 350;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: Get.width,
          height: h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(logic.state.portrait))),
          foregroundDecoration:
              BoxDecoration(color: Colors.black.withOpacity(0.5)),
        ),
        Container(
          width: Get.width,
          height: h,
          padding: const EdgeInsetsDirectional.only(
              top: 10, start: 10, end: 10, bottom: 20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0x59EE78BB),
            Color(0x59FFCB7D),
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    padding: const EdgeInsetsDirectional.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(100),
                        border: Border.all(
                            width: 2, color: const Color(0xFFFF3B7A))),
                    margin: const EdgeInsetsDirectional.only(end: 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadiusDirectional.all(
                          Radius.circular(50)),
                      child: cachedImage(logic.state.portrait),
                    ),
                  ),
                  if (logic.state.host.followed != null)
                    PositionedDirectional(
                        top: 8,
                        start: 8,
                        child: LineState(logic.state.lineState)),
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(bottom: 3),
                child: AutoSizeText(
                  logic.state.host.showNickName,
                  maxFontSize: 22,
                  minFontSize: 12,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AgeAndSex(logic.state.host.showBirthday),
                  const SizedBox(
                    width: 5,
                  ),
                  StateWidget(
                      LineType.offline.number, "ID: ${logic.state.host.showId}")
                ],
              ),
              if (logic.state.host.hostTags.isNotEmpty)
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 10),
                  child: BuildTags(logic.state.host.hostTags),
                ),
              Container(
                height: 82,
                width: Get.width,
                margin: const EdgeInsetsDirectional.only(top: 10),
                padding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 5, start: 10, end: 10),
                child: Text(
                  logic.state.host.showIntro,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
