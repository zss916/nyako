import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/change_password/index.dart';
import 'package:oliapro/pages/widget/base_button.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/widget/animated_button.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordBody> {
  final logic = Get.find<ChangePasswordLogic>();
  final TextEditingController _textEditingController =
      TextEditingController(text: "");
  final TextEditingController _textEditingController2 =
      TextEditingController(text: "");
  final TextEditingController _textEditingController3 =
      TextEditingController(text: "");
  FocusNode focusNode_1 = FocusNode();
  FocusNode focusNode_2 = FocusNode();
  FocusNode focusNode_3 = FocusNode();
  late bool setObscure = true;

  ///默认密码模式

  @override
  void initState() {
    super.initState();
    _textEditingController.text = UserInfo.to.getVisitorPassword();
  }

  @override
  void dispose() {
    if (focusNode_1.hasFocus) {
      focusNode_1.unfocus();
      focusNode_1.dispose();
    }
    if (focusNode_2.hasFocus) {
      focusNode_2.unfocus();
      focusNode_2.dispose();
    }
    if (focusNode_3.hasFocus) {
      focusNode_3.unfocus();
      focusNode_3.dispose();
    }
    _textEditingController.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsetsDirectional.only(top: 0),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 10, top: 2),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(55),
                    child: cachedImage(UserInfo.to.userPortrait,
                        width: 80, height: 80),
                  ),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 10),
                    child: Text(
                      "ID:${UserInfo.to.username}",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppConstants.fontsBold,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (focusNode_2.hasFocus) {
                  focusNode_2.unfocus();
                }
                if (focusNode_3.hasFocus) {
                  focusNode_3.unfocus();
                }
                if (!focusNode_1.hasFocus) {
                  focusNode_1.requestFocus();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(14),
                ),
                //height: 62,
                alignment: AlignmentDirectional.center,
                width: double.infinity,
                child: TextField(
                  controller: _textEditingController,
                  obscureText: setObscure,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    suffix: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            setObscure = !setObscure;
                          });
                        }
                      },
                      child: Image.asset(
                        setObscure ? Assets.imgCloseEye : Assets.imgOpenEye,
                        width: 22,
                        height: 22,
                        matchTextDirection: true,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20),
                    hintText: Tr.app_promapp_password.tr,
                    hintStyle: const TextStyle(
                      color: AppColors.textColor333,
                    ),
                  ),
                  focusNode: focusNode_1,
                ),
              ),
            ).onTextItemLabel(index: 1),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                if (focusNode_1.hasFocus) {
                  focusNode_1.unfocus();
                }
                if (focusNode_3.hasFocus) {
                  focusNode_3.unfocus();
                }
                if (!focusNode_2.hasFocus) {
                  focusNode_2.requestFocus();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(14),
                ),
                height: 62,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: TextField(
                  controller: _textEditingController2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: Tr.app_input_new_pwd.tr,
                    hintStyle: const TextStyle(color: AppColors.textColor999),
                  ),
                  focusNode: focusNode_2,
                ),
              ),
            ).onTextItemLabel(index: 2),
            Container(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                if (focusNode_1.hasFocus) {
                  focusNode_1.unfocus();
                }
                if (focusNode_2.hasFocus) {
                  focusNode_2.unfocus();
                }
                if (!focusNode_3.hasFocus) {
                  focusNode_3.requestFocus();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(14),
                ),
                height: 62,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: TextField(
                  controller: _textEditingController3,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: Tr.app_input_new_pwd_again.tr,
                    hintStyle: const TextStyle(color: AppColors.textColor999),
                  ),
                  focusNode: focusNode_3,
                ),
              ),
            ).onTextItemLabel(index: 3),
            const SizedBox(
              height: 30,
            ),
            AnimatedButton(
              onCall: () {
                String oldPassword = _textEditingController.text;
                String newPassword = _textEditingController2.text;
                String newAgainPassword = _textEditingController3.text;

                if (oldPassword.isEmpty) {
                  AppLoading.toast(Tr.app_promapp_password.tr);
                  return;
                }
                if (newPassword.isEmpty || newAgainPassword.isEmpty) {
                  AppLoading.toast(Tr.app_input_new_pwd.tr);
                  return;
                }
                if (newPassword != newAgainPassword) {
                  AppLoading.toast(Tr.app_prompt_password_different.tr);
                  return;
                }

                if (focusNode_1.hasFocus) {
                  focusNode_1.unfocus();
                  focusNode_1.dispose();
                }
                if (focusNode_2.hasFocus) {
                  focusNode_2.unfocus();
                  focusNode_2.dispose();
                }
                if (!focusNode_3.hasFocus) {
                  focusNode_3.unfocus();
                  focusNode_3.dispose();
                }

                logic.changePassword(
                    oldPassword, newPassword, newAgainPassword);
              },
              child: BaseButton(Tr.app_base_confirm.tr),
            )
          ],
        ),
      ),
    );
  }
}
