import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/main/me/invite_code/index.dart';

class InviteCodeBody extends StatelessWidget {
  final InviteCodeLogic logic;

  const InviteCodeBody(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InviteCodeLogic>(
      assignId: true,
      builder: (logic) {
        return Container(
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, left: 0, right: 0),
                child: Text(
                  "*${logic.stateStr ?? Tr.app_binding_code_tip1.tr}",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              buildInvite(logic),
              btn(logic)
            ],
          ),
        );
      },
    );
  }

  Widget buildInvite(InviteCodeLogic logic) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadiusDirectional.circular(14)),
      margin: const EdgeInsetsDirectional.only(top: 20, start: 0, end: 0),
      child: TextField(
        enabled: logic.state == 0,
        controller: logic.controller,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: logic.state == 0 ? Colors.white : Colors.white,
        ),
        decoration: InputDecoration(
          filled: true,
          isCollapsed: true,
          fillColor: logic.state == 0 ? Colors.black : Colors.black,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          contentPadding: const EdgeInsets.all(15.0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 0.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 0.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 0.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              )),
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
          height: 34,
          constraints: const BoxConstraints(minWidth: 80),
          margin: const EdgeInsetsDirectional.only(start: 5, end: 5, top: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(30),
              gradient: AppColors.btnGradient),
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
