import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/main/me/info/index.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/pages/widget/short_base_button.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_loading.dart';

void showEditIntroSheet(String showIntro) {
  Get.bottomSheet(
      BottomArrowWidget(
        child: EditIntroPage(showIntro),
        onBack: () => Get.back(),
      ),
      isScrollControlled: true,
      settings: const RouteSettings(name: AppPages.editIntroSheet));
}

class EditIntroPage extends StatefulWidget {
  final String content;

  const EditIntroPage(this.content, {super.key});

  @override
  State<EditIntroPage> createState() => _EditIntroPageState();
}

class _EditIntroPageState extends State<EditIntroPage> {
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;
  bool isSave = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController?.addListener(() {
      if ((_textEditingController?.text.length ?? 0) > 200) {
        _textEditingController?.text =
            _textEditingController?.text.substring(0, 200) ?? "";
        _textEditingController?.selection = TextSelection(
            baseOffset: _textEditingController?.text.length ?? 0,
            extentOffset: _textEditingController?.text.length ?? 0);
      }
      if (mounted) {
        setState(() {
          isSave = _textEditingController?.text.isNotEmpty ?? false;
        });
      }
    });
    _textEditingController?.text =
        widget.content.replaceAll(RegExp(r"\d"), "*");
    _focusNode = FocusNode();
    _focusNode?.addListener(() {
      if (_focusNode!.hasFocus) {
      } else {}
    });
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logic = safeFind<EditLogic>();
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(24), topEnd: Radius.circular(24))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(top: 10, bottom: 10),
            width: 42,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadiusDirectional.all(Radius.circular(3))),
          ),
          Text(
            Tr.app_details_signature.tr,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsetsDirectional.only(start: 15, end: 5),
            margin: const EdgeInsetsDirectional.only(
                top: 15, start: 15, end: 15, bottom: 5),
            decoration: const BoxDecoration(
                color: Color(0xFFF4F5F6),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: const Color(0xFF7934F0),
                    minLines: 6,
                    maxLines: 8,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(200),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Tr.app_not_exceed.trArgs(["200"]),
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                /* IconButton(
                    onPressed: () {
                      _textEditingController?.text = "";
                    },
                    icon: Image.asset(A.assets_img_close,width: 22,height: 22,))*/
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_textEditingController?.text != null &&
                  _textEditingController!.text.isNotEmpty) {
                _focusNode?.unfocus();
                String? str = _textEditingController?.text
                    .replaceAll(' ', "")
                    .replaceAll('\n', "");
                logic?.updateUser(intro: str ?? '');
                Get.back();
              } else {
                AppLoading.toast(Tr.app_not_entered.tr);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 30, top: 20),
              child: ShortBaseButton(
                Tr.app_base_confirm.tr,
                isSave: isSave,
              ),
            ),
          )
        ],
      ),
    );
  }
}
