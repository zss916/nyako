import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/init/login/index.dart';
import 'package:oliapro/pages/init/login/widget/build_account_login.dart';
import 'package:oliapro/pages/init/login/widget/build_google_login.dart';
import 'package:oliapro/pages/init/login/widget/build_tourist_login.dart';
import 'package:oliapro/pages/init/login/widget/login_check.dart';
import 'package:oliapro/services/user_info.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<LoginLogic>(
      init: LoginLogic(),
      builder: (logic) {
        return SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              PositionedDirectional(
                  top: 0,
                  start: 0,
                  end: 0,
                  child: Image.asset(
                    Assets.iconLoginBg,
                    matchTextDirection: true,
                  )),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 100),
                    child: Image.asset(
                      Assets.iconLoginLogo,
                      width: 142,
                      height: 142,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      BuildGoogleLogin(logic),
                      if (logic.isShowGoogle)
                        PositionedDirectional(
                            top: 2,
                            end: 44,
                            child: Container(
                              width: 90,
                              height: 24,
                              alignment: AlignmentDirectional.topCenter,
                              padding: const EdgeInsetsDirectional.only(
                                  top: 3, start: 2, end: 2, bottom: 3),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(10),
                                      bottomStart: Radius.circular(10),
                                      bottomEnd: Radius.zero,
                                      topEnd: Radius.circular(10)),
                                  color: Color(0xFF4AFFE4)),
                              child: AutoSizeText(
                                Tr.appLastLogin.tr,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                maxFontSize: 12,
                                minFontSize: 8,
                                style: const TextStyle(
                                    color: Color(0xFF07435E), fontSize: 12),
                              ),
                            ))
                    ],
                  ),
                  if (logic.isShowGust) BuildTouristLogin(logic),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      BuildAccountLogin(logic),
                      if (!logic.isShowGoogle && !logic.isShowGust)
                        PositionedDirectional(
                            top: 2,
                            end: 40,
                            child: Container(
                              width: 90,
                              height: 24,
                              alignment: AlignmentDirectional.topCenter,
                              padding: const EdgeInsetsDirectional.only(
                                  top: 3, start: 2, end: 2, bottom: 3),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(10),
                                      bottomStart: Radius.circular(10),
                                      bottomEnd: Radius.zero,
                                      topEnd: Radius.circular(10)),
                                  color: Color(0xFF4AFFE4)),
                              child: AutoSizeText(
                                Tr.appLastLogin.tr,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                maxFontSize: 12,
                                minFontSize: 8,
                                style: const TextStyle(
                                    color: Color(0xFF07435E), fontSize: 12),
                              ),
                            ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 15),
                    child: LoginCheck(
                      UserInfo.to.getCheck(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              //  if (AppConstants.haveTestLogin) const AppLoginTest()
            ],
          ),
        );
      });
}
