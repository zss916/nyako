import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/login_agree_dialog.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/init/account/login/index.dart';
import 'package:oliapro/pages/init/account/login/widget/login_btn.dart';
import 'package:oliapro/pages/init/login/widget/login_check.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';

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
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
              top: 0,
              start: 0,
              end: 0,
              child: Image.asset(
                Assets.iconAccountLoginBg,
                matchTextDirection: true,
              )),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsetsDirectional.only(top: 100, bottom: 10),
                  child: Image.asset(
                    Assets.iconSmallLogo,
                    width: 52,
                    height: 52,
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 10, end: 10, bottom: 0),
                  child: Text(
                    Tr.app_login_username.tr,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 10,
                    end: 10,
                  ),
                  child: Text(
                    Tr.app_login_top_title.trArgs([AppConstants.appName]),
                    maxLines: 1,
                    style: const TextStyle(
                        color: Color(0xFF7D6E87),
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 54,
                  width: double.maxFinite,
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(16)),
                  margin: const EdgeInsetsDirectional.only(
                      top: 5, bottom: 10, start: 40, end: 40),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 12),
                        child: Image.asset(
                          Assets.iconAccountIc,
                          matchTextDirection: true,
                          width: 22,
                          height: 22,
                        ),
                      ),
                      const VerticalDivider(
                        width: 1,
                        color: Color(0xFFD8D8D8),
                        indent: 15,
                        endIndent: 15,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: TextField(
                        controller: _editNameCtrl,
                        cursorColor: const Color(0xFF982AFF),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: Tr.app_details_edit_name.tr,
                          hintStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ))
                    ],
                  ),
                ),
                Container(
                  height: 54,
                  width: double.maxFinite,
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(16)),
                  margin: const EdgeInsetsDirectional.only(
                      top: 10, bottom: 10, start: 40, end: 40),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 12),
                        child: Image.asset(
                          Assets.iconPsdIc,
                          matchTextDirection: true,
                          width: 22,
                          height: 22,
                        ),
                      ),
                      const VerticalDivider(
                        width: 1,
                        color: Color(0xFFD8D8D8),
                        indent: 15,
                        endIndent: 15,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: TextField(
                        controller: _editPwdCtrl,
                        //maxLength: 15,
                        obscureText: _obscureText,
                        cursorColor: const Color(0xFF982AFF),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: Tr.app_promapp_password.tr,
                            hintStyle: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFFBCB6C4),
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
                                  _obscureText
                                      ? Assets.iconPsdH
                                      : Assets.iconPsdV,
                                  height: 22,
                                  width: 22,
                                  matchTextDirection: true,
                                ),
                              ),
                            )),
                      ))
                    ],
                  ),
                ),
                GestureDetector(
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
                  onTap: () {
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
                  margin:
                      EdgeInsetsDirectional.only(top: h, start: 15, end: 15),
                  child: LoginCheck(
                    UserInfo.to.getCheck(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
