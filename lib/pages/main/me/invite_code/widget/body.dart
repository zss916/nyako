import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/invite_code/index.dart';

class InviteCodeBody extends StatelessWidget {
  //final InviteCodeLogic logic;

  const InviteCodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: Image.asset(
              Assets.iconBindCodeBg,
              fit: BoxFit.fitWidth,
              matchTextDirection: true,
            )),
        //Tr.app_my_binding_code.tr,
        Column(
          children: [
            Container(
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.only(
                  start: 40, end: 40, top: 100),
              child: Text(
                Tr.app_my_binding_code2.tr,
                //language_vi[Tr.app_my_binding_code] ?? "",
                //language_tr[Tr.app_my_binding_code] ?? "",
                //language_th[Tr.app_my_binding_code] ?? "",
                //language_pt[Tr.app_my_binding_code] ?? "",
                //language_ind[Tr.app_my_binding_code] ?? "",
                //language_hi[Tr.app_my_binding_code] ?? "",
                //language_es[Tr.app_my_binding_code] ?? "",
                //language_vi[Tr.app_my_binding_code] ?? "",
                //language_ar[Tr.app_my_binding_code] ?? "",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
            ),
            GetBuilder<InviteCodeLogic>(
              assignId: true,
              builder: (logic) {
                return Container(
                  margin: const EdgeInsetsDirectional.only(
                      start: 30, end: 30, top: 20),
                  child: Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 30, left: 0, right: 0),
                        child: Text(
                          "*${logic.stateStr ?? Tr.app_binding_code_tip1.tr}",
                          style: TextStyle(
                              color: logic.state == 0
                                  ? Colors.black
                                  : const Color(0xFF3BC2FF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      buildInvite(logic),
                      btn(logic)
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }

  Widget buildInvite(InviteCodeLogic logic) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF4F5F6),
          borderRadius: BorderRadiusDirectional.circular(14)),
      margin: const EdgeInsetsDirectional.only(top: 20, start: 0, end: 0),
      child: TextField(
        enabled: logic.state == 0,
        controller: logic.controller,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: logic.state == 0 ? Colors.black : Colors.black,
        ),
        decoration: InputDecoration(
          //filled: true,
          isCollapsed: true,
          //fillColor: const Color(0xFFF4F5F6),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          contentPadding: const EdgeInsets.all(15.0),
          border: InputBorder.none,
          /* border: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              )),*/
          hintText: Tr.app_input_invite_code.tr,
        ),
      ),
    );
  }

  Widget btn(InviteCodeLogic logic) {
    return GestureDetector(
      onTap: () => logic.bindCode(),
      child: FittedBox(
        child: Container(
          height: 42,
          constraints: const BoxConstraints(minWidth: 80),
          margin: const EdgeInsetsDirectional.only(start: 5, end: 5, top: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(30),
              color: const Color(0xFF9341FF)),
          child: AutoSizeText(
            Tr.app_binding.tr,
            maxFontSize: 16,
            minFontSize: 6,
            maxLines: 2,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
