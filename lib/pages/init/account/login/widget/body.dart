import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/login_agree_dialog.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/init/account/login/index.dart';
import 'package:oliapro/pages/init/account/login/widget/login_btn.dart';
import 'package:oliapro/pages/init/login/widget/login_check.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/widget/animated_button.dart';

class AccountLoginBody extends StatefulWidget {
  final AccountLoginLogic logic;
  const AccountLoginBody(this.logic, {super.key});
  @override
  State<AccountLoginBody> createState() => _AccountLoginBodyState();
}

class _AccountLoginBodyState extends State<AccountLoginBody> with RouteAware {
  late final TextEditingController _editNameCtrl =
      TextEditingController(text: "");
  late final TextEditingController _editPwdCtrl =
      TextEditingController(text: "");
  String title = Tr.app_account_login.tr;
  late double h = (150 * Get.height) / 812;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // String password = UserInfo.to.getVisitorPassword();
    // String account = UserInfo.to.getVisitorAccount();
    /*if (account.isNotEmpty) {
      _editNameCtrl.text = account;
    }
    if (password.isNotEmpty) {
      _editPwdCtrl.text = password;
    }*/
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppPages.observer.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _editNameCtrl.dispose();
    _editPwdCtrl.dispose();
    AppPages.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: 250.h,
            padding: const EdgeInsetsDirectional.only(
                start: 10, end: 10, bottom: 10),
            alignment: AlignmentDirectional.bottomCenter,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage(Assets.imgLoginTopBg))),
            child: AutoSizeText(
              Tr.app_login_username.tr,
              maxLines: 1,
              maxFontSize: 36,
              minFontSize: 20,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
                top: 5, bottom: 10, start: 15, end: 15),
            child: TextField(
              controller: _editNameCtrl,
              maxLength: 15,
              cursorColor: const Color(0xFF982AFF),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                counterText: '',
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF7934F0)),
                ),
                /*border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),*/
                hintText: Tr.app_details_edit_name.tr,
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
                top: 10, bottom: 10, start: 15, end: 15),
            child: TextField(
              controller: _editPwdCtrl,
              maxLength: 15,
              obscureText: _obscureText,
              cursorColor: const Color(0xFF982AFF),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  counterText: '',
                  /*border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),*/
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7934F0)),
                  ),
                  hintText: Tr.app_promapp_password.tr,
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  suffix: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsetsDirectional.all(1),
                      child: Image.asset(
                        _obscureText ? Assets.imgPsdH : Assets.imgPsdV,
                        height: 22,
                        width: 22,
                        matchTextDirection: true,
                      ),
                    ),
                  )),
            ),
          ),
          AnimatedButton(
            child: LoginBtn(
              child: Center(
                child: Text(
                  Tr.app_account_login.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onCall: () {
              final account = _editNameCtrl.value.text.trim();
              final password = _editPwdCtrl.value.text.trim();
              if (UserInfo.to.getCheck()) {
                widget.logic.onSubmit(account, password);
              } else {
                showAgreeDialog(() {
                  widget.logic.onSubmit(account, password);
                });
              }
            },
          ),

          /* Container(
            width: Get.width,
            margin:
                const EdgeInsetsDirectional.only(top: 15, start: 15, end: 15),
            alignment: AlignmentDirectional.center,
            child: GestureDetector(
                onTap: () {
                  if (UserInfo.to.getCheck()) {
                    safeFind<LoginLogic>()?.visitorLogin();
                  } else {
                    showAgreeDialog(() {
                      safeFind<LoginLogic>()?.visitorLogin();
                    });
                  }
                },
                child: Text(
                  Tr.app_login_register.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                )),
          ),*/
          Container(
            margin: EdgeInsetsDirectional.only(top: h, start: 15, end: 15),
            child: LoginCheck(
              UserInfo.to.getCheck(),
            ),
          ),
        ],
      ),
    );
  }
}
