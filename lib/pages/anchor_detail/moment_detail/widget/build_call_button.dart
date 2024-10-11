import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_moment_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildCallButton extends StatelessWidget {
  final MomentDetail data;

  const BuildCallButton(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return data.isChat
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => ARoutes.toChatPage(data.getUid),
                child: Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: AppColors.btnGradient2,
                    borderRadius: BorderRadiusDirectional.circular(45),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(
                        Assets.imgMsgIcon,
                        width: 35,
                        height: 35,
                        matchTextDirection: true,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: InkWell(
                onTap: () =>
                    ARoutes.toLocalCall(data.getUid, data.showPortrait),
                child: Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient: AppColors.btnGradient,
                    borderRadius: BorderRadiusDirectional.circular(45),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      Image.asset(
                        Assets.imgCallIcon,
                        width: 35,
                        height: 35,
                        matchTextDirection: true,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 5),
                        child: Text(
                          Tr.app_grade_video_chat.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ))
            ],
          )
        : GestureDetector(
            onTap: () => ARoutes.toChatPage(data.getUid),
            child: Container(
              height: 50,
              width: 265,
              decoration: BoxDecoration(
                gradient: AppColors.btnGradient2,
                borderRadius: BorderRadiusDirectional.circular(45),
                border: const GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Color(0xFFD5DAFF),
                    Color(0xFF97A5FE),
                    Color(0xFF8BB3FD),
                    Color(0xFF7D98FA),
                  ]),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Image.asset(
                    Assets.imgMsgIcon,
                    width: 30,
                    height: 30,
                    matchTextDirection: true,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    child: Text(
                      Tr.app_base_message.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
  }
}
