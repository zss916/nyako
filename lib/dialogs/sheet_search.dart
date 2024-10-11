import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/widget/base_button.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/widget/animated_button.dart';

void showSearchConfirm() {
  Get.bottomSheet(const SearchConfirmWdg(),
      isScrollControlled: true,
      settings: const RouteSettings(name: AppPages.searchSheet));
}

class SearchConfirmWdg extends StatefulWidget {
  const SearchConfirmWdg({super.key});

  @override
  State<SearchConfirmWdg> createState() => _SearchConfirmWdgState();
}

class _SearchConfirmWdgState extends State<SearchConfirmWdg> {
  late final TextEditingController __textEditingCtrl = TextEditingController();
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode?.addListener(() {
      if (_focusNode!.hasFocus) {
      } else {}
    });
  }

  @override
  void dispose() {
    _focusNode?.unfocus();
    __textEditingCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomArrowWidget(
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            gradient: AppColors.gradientDialogsBg,
            borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(20), topEnd: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(top: 10, bottom: 0),
              color: Colors.transparent,
              width: 42,
              height: 0,
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 10),
              width: 30,
              height: 6,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(3))),
            ),
            Text(
              Tr.app_setting_search.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsetsDirectional.only(start: 15, end: 5),
              margin: const EdgeInsetsDirectional.only(
                  top: 15, start: 15, end: 15, bottom: 5),
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: Row(
                children: [
                  /*Container(
                    margin: const EdgeInsetsDirectional.only(end: 3, top: 0),
                    child: Image.asset(
                      Assets.imgSearchIcon,
                      width: 25,
                      height: 25,
                      matchTextDirection: true,
                    ),
                  ),*/
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: const Color(0xFFAC53FB),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      controller: __textEditingCtrl,
                      focusNode: _focusNode,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        /*suffix: GestureDetector(
                          onTap: () {
                            __textEditingCtrl.clear();
                          },
                          child: Image.asset(
                            Assets.imageCancel,
                            width: 22,
                            height: 22,
                            matchTextDirection: true,
                          ),
                        ),*/
                        border: InputBorder.none,
                        //Tr.app_search_id_hint.tr
                        //Tr.app_message_send_input.tr
                        contentPadding:
                            const EdgeInsetsDirectional.only(bottom: 0),
                        hintText: Tr.app_logout_tip_ph.tr,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedButton(
              onCall: () async {
                _focusNode?.unfocus();
                if (__textEditingCtrl.text.isNotEmpty) {
                  Get.back();
                  search(__textEditingCtrl.text);
                } else {
                  AppLoading.toast(Tr.app_not_entered.tr);
                }
              },
              child: Container(
                margin: const EdgeInsetsDirectional.only(
                    top: 20, bottom: 30, start: 40, end: 40),
                child: BaseButton(Tr.app_base_confirm.tr),
              ),
            )
          ],
        ),
      ),
      onBack: () {
        Get.back();
      },
    );
  }
}

void search(String anchorId) async {
  final data = await CommonAPI.searchAnchor(anchorId);
  ARoutes.toAnchorDetail(data.getUid);
}
