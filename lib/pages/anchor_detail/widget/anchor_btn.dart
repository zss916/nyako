import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/widget/semantics/label.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

class AnchorBtn extends StatelessWidget {
  final HostDetail data;

  const AnchorBtn(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return button(data);
  }

  Widget button(HostDetail data) {
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
                    gradient: const LinearGradient(colors: [
                      Color(0xFF7770FF),
                      Color(0xFF5138FF),
                    ]),
                    borderRadius: BorderRadiusDirectional.circular(45),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(
                        Assets.imgToMsgIcon,
                        width: 30,
                        height: 30,
                        matchTextDirection: true,
                      )
                    ],
                  ),
                ),
              ).onLabel(label: SemanticsLabel.message),
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
                        Assets.imgToCallIcon,
                        matchTextDirection: true,
                        width: 32,
                        height: 32,
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
              ).onLabel(label: SemanticsLabel.call))
            ],
          )
        : GestureDetector(
            onTap: () => ARoutes.toChatPage(data.getUid),
            child: Container(
              height: 50,
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFF7770FF),
                  Color(0xFF5138FF),
                ]),
                borderRadius: BorderRadiusDirectional.circular(45),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Image.asset(
                    Assets.imgToMsgIcon,
                    width: 32,
                    height: 32,
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
