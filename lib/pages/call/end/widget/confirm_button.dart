import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/call/end/index.dart';

class ConfirmButton extends StatelessWidget {
  final EndLogic logic;

  const ConfirmButton(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: logic.closeMe,
      child: Container(
        height: 54,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Text(
          Tr.app_base_confirm.tr,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
