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
import 'package:oliapro/pages/init/login/widget/login_logo.dart';
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
              const LoginLogo(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
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
                            end: 50,
                            child: Container(
                              width: 90,
                              height: 33,
                              alignment: AlignmentDirectional.topCenter,
                              padding: const EdgeInsetsDirectional.only(
                                  top: 3, start: 2, end: 2),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      matchTextDirection: true,
                                      image: ExactAssetImage(
                                          Assets.imgLastLoginBg))),
                              child: AutoSizeText(
                                Tr.appLastLogin.tr,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                maxFontSize: 12,
                                minFontSize: 8,
                                style: const TextStyle(
                                    color: Color(0xFF8A1292), fontSize: 12),
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
                            end: 50,
                            child: Container(
                              width: 90,
                              height: 33,
                              alignment: AlignmentDirectional.topCenter,
                              padding: const EdgeInsetsDirectional.only(
                                  top: 3, start: 2, end: 2),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      matchTextDirection: true,
                                      image: ExactAssetImage(
                                          Assets.imgLastLoginBg))),
                              child: AutoSizeText(
                                Tr.appLastLogin.tr,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                maxFontSize: 12,
                                minFontSize: 8,
                                style: const TextStyle(
                                    color: Color(0xFF8A1292), fontSize: 12),
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
