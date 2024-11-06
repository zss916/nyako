import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/change_password/index.dart';
import 'package:nyako/pages/widget/bottom_arrow_widget.dart';
import 'package:nyako/pages/widget/short_base_button.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/widget/animated_button.dart';
import 'package:nyako/widget/semantics/semantics_widget.dart';

class SetPassWord extends StatelessWidget {
  final String title = Tr.appYourPsk.tr;
  final String title1 = Tr.appYourNotSetPsk.tr;
  final String title2 = Tr.appSaveAccountContent.tr;

  SetPassWord({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(
                top: 20, bottom: 20, start: 10, end: 10),
            child: Image.asset(
              Assets.iconPassword,
              width: 128,
              height: 128,
              matchTextDirection: true,
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.bold),
            ),
          ),
          if (UserInfo.to.getVisitorPassword().isEmpty)
            Container(
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.only(
                  start: 30, end: 30, top: 20, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    child: Image.asset(
                      Assets.iconWarmS,
                      width: 20,
                      height: 20,
                      matchTextDirection: true,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    title1,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConstants.fontsRegular,
                        fontSize: 15),
                  ))
                ],
              ),
            ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsetsDirectional.only(
                start: 30, end: 30, top: 15, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  child: Image.asset(
                    Assets.iconPsdS,
                    width: 20,
                    height: 20,
                    matchTextDirection: true,
                  ),
                ),
                Expanded(
                    child: Text(
                  title2,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstants.fontsRegular,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ))
              ],
            ),
          ),
          if (UserInfo.to.getVisitorPassword().isNotEmpty)
            Container(
              width: double.maxFinite,
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 12, vertical: 17),
              margin:
                  const EdgeInsetsDirectional.only(top: 20, start: 30, end: 30),
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(12),
                  color: const Color(0xFFF4F5F6)),
              child: Text(
                UserInfo.to.getVisitorPassword(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: const Color(0xFFBCB6C4),
                    fontSize: 15,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.w500),
              ),
            ),
          InkWell(
            onTap: () => setPassWordDialog(),
            child: Container(
              height: 52,
              margin:
                  const EdgeInsetsDirectional.only(start: 30, end: 30, top: 30),
              alignment: AlignmentDirectional.center,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: const Color(0xFF9341FF),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Text(
                Tr.app_base_confirm.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppConstants.fontsBold,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void setPassWordDialog() {
  Get.bottomSheet(
    BottomArrowWidget(
      child: const ChangePasswordBody(),
      onBack: () => Get.back(),
    ),
    settings: const RouteSettings(name: AppPages.setPassWordSheet),
    persistent: true,
    isScrollControlled: true,
  );
}

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordBody> {
  final logic = Get.find<ChangePasswordLogic>();
  /*final TextEditingController _textEditingController =
      TextEditingController(text: "");*/
  final TextEditingController _textEditingController2 =
      TextEditingController(text: "");
  final TextEditingController _textEditingController3 =
      TextEditingController(text: "");
  // FocusNode focusNode_1 = FocusNode();
  FocusNode focusNode_2 = FocusNode();
  FocusNode focusNode_3 = FocusNode();
  late bool setObscure = true;
  bool isSave = false;
  bool isSetNewPsd = false;
  bool isSetConfirmPsd = false;

  ///默认密码模式

  @override
  void initState() {
    super.initState();
    //_textEditingController.text = UserInfo.to.getVisitorPassword();

    _textEditingController2.addListener(() {
      if (mounted) {
        setState(() {
          isSetNewPsd = _textEditingController2.text.isNotEmpty;
        });
      }
    });

    _textEditingController3.addListener(() {
      if (mounted) {
        setState(() {
          isSetConfirmPsd = _textEditingController3.text.isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    /*if (focusNode_1.hasFocus) {
      focusNode_1.unfocus();
      focusNode_1.dispose();
    }*/
    if (focusNode_2.hasFocus) {
      focusNode_2.unfocus();
      focusNode_2.dispose();
    }
    if (focusNode_3.hasFocus) {
      focusNode_3.unfocus();
      focusNode_3.dispose();
    }
    //_textEditingController.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsetsDirectional.all(30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(24), topEnd: Radius.circular(24))),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 20),
            child: Text(
              Tr.app_change_pwd.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              /*if (focusNode_1.hasFocus) {
                focusNode_1.unfocus();
              }*/
              if (focusNode_3.hasFocus) {
                focusNode_3.unfocus();
              }
              if (!focusNode_2.hasFocus) {
                focusNode_2.requestFocus();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5F6),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 62,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: TextField(
                controller: _textEditingController2,
                style: const TextStyle(
                  color: Colors.black,
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
              /*if (focusNode_1.hasFocus) {
                focusNode_1.unfocus();
              }*/
              if (focusNode_2.hasFocus) {
                focusNode_2.unfocus();
              }
              if (!focusNode_3.hasFocus) {
                focusNode_3.requestFocus();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5F6),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 62,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: TextField(
                controller: _textEditingController3,
                style: const TextStyle(
                  color: Colors.black,
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
              // String oldPassword = _textEditingController.text;
              String newPassword = _textEditingController2.text;
              String newAgainPassword = _textEditingController3.text;

              /*if (oldPassword.isEmpty) {
                AppLoading.toast(Tr.app_promapp_password.tr);
                return;
              }*/
              if (newPassword.isEmpty || newAgainPassword.isEmpty) {
                AppLoading.toast(Tr.app_input_new_pwd.tr);
                return;
              }
              if (newPassword != newAgainPassword) {
                AppLoading.toast(Tr.app_prompt_password_different.tr);
                return;
              }

              /*if (focusNode_1.hasFocus) {
                focusNode_1.unfocus();
                focusNode_1.dispose();
              }*/
              if (focusNode_2.hasFocus) {
                focusNode_2.unfocus();
                focusNode_2.dispose();
              }
              if (!focusNode_3.hasFocus) {
                focusNode_3.unfocus();
                focusNode_3.dispose();
              }

              logic.changePassword(UserInfo.to.getVisitorPassword(),
                  newPassword, newAgainPassword);
            },
            child: ShortBaseButton(
              Tr.app_base_confirm.tr,
              isSave: (isSetNewPsd && isSetConfirmPsd),
            ),
          )
        ],
      ),
    );
  }
}
