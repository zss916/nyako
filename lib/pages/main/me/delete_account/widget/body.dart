import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/dialog_delete_account.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/widget/base_button.dart';
import 'package:nyako/widget/animated_button.dart';

class DeleteAccountBody extends StatelessWidget {
  const DeleteAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 30, bottom: 30),
          alignment: AlignmentDirectional.center,
          child: Image.asset(
            Assets.iconDeleteBg,
            width: 250,
            height: 130,
            matchTextDirection: true,
          ),
        ),
        RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(children: [
              TextSpan(
                  text: 'Are you',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              TextSpan(
                  text: ' sure?',
                  style: TextStyle(
                      color: Color(0xFFFF33A7),
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            ])),
        Container(
          margin: const EdgeInsetsDirectional.only(
              top: 20, start: 25, end: 25, bottom: 5),
          child: Text(
            Tr.app_account_delete_content.tr,
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        const Spacer(),
        const SizedBox(
          height: 5,
        ),
        AnimatedButton(
          onCall: () => Get.back(),
          child: Container(
            margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: BaseButton(Tr.app_base_cancel.tr),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            showDeleteAccount();
            /*AccountAPI.deleteAccount()
                  .whenComplete(() => AppPages.toDeleteAccount());*/
          },
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 10),
            child: Text(
              Tr.app_account_cancellation.tr,
              style: const TextStyle(
                  color: Color(0xFF9B989D),
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
