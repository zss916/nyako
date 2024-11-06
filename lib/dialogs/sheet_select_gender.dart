import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/info/index.dart';
import 'package:nyako/pages/widget/bottom_arrow_widget.dart';
import 'package:nyako/pages/widget/short_base_button.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_loading.dart';

void showSelectGenderSheet() {
  if (StorageService.to.getHadSetGender()) {
    AppLoading.toast(Tr.app_mine_edit_sex.tr);
    return;
  }
  Get.bottomSheet(
      BottomArrowWidget(
        child: Container(
            alignment: Alignment.center,
            width: Get.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(24),
                    topEnd: Radius.circular(24))),
            child: Container(
              margin: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Tr.app_details_sex.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(Tr.app_mine_edit_sex.tr,
                        softWrap: true,
                        style: TextStyle(
                            color: const Color(0xFF9B989D),
                            fontSize: 14,
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.normal)),
                  ),
                  const RadioWidget()
                ],
              ),
            )),
        onBack: () {
          Get.back();
        },
      ),
      isScrollControlled: true,
      barrierColor: const Color(0x7F333333),
      settings: const RouteSettings(name: AppPages.selectGenderSheet));
}

class RadioWidget extends StatefulWidget {
  const RadioWidget({super.key});

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  int select = -1; // -1 未选中，0 女，1 男
  final logic = safeFind<EditLogic>();
  bool isSave = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      select = 1;
                      isSave = true;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        select == 1 ? Assets.iconMaleS : Assets.iconMale,
                        width: 120,
                        height: 160,
                        matchTextDirection: true,
                      ),
                      Visibility(
                          visible: false,
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(top: 5),
                            child: Text(
                              Tr.app_man.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFAEADB5),
                                  fontSize: 16),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      select = 0;
                      isSave = true;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        select == 0 ? Assets.iconFemaleS : Assets.iconFemale,
                        width: 120,
                        height: 160,
                        matchTextDirection: true,
                      ),
                      Visibility(
                          visible: false,
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(top: 5),
                            child: Text(
                              Tr.app_woman.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFAEADB5),
                                  fontSize: 16),
                            ),
                          ))
                    ],
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _btn(),
      ],
    );
  }

  Widget _btn() {
    return InkWell(
      onTap: () {
        if (select == -1) {
          AppLoading.toast(Tr.app_publish_select.tr);
        } else {
          logic?.updateUser(gender: select);
          Get.back();
        }
      },
      child: ShortBaseButton(
        Tr.app_base_confirm.tr,
        isSave: isSave,
      ),
    );
  }
}
