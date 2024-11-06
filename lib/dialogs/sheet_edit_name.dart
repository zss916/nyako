import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/pages/main/me/info/index.dart';
import 'package:nyako/pages/widget/bottom_arrow_widget.dart';
import 'package:nyako/pages/widget/short_base_button.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_loading.dart';

void showEditNickNameSheet(String nickName) {
  Get.bottomSheet(
      BottomArrowWidget(
        child: EditNickNamePage(content: nickName),
        onBack: () => Get.back(),
      ),
      isScrollControlled: true,
      settings: const RouteSettings(name: AppPages.editNameSheet));
}

class EditNickNamePage extends StatefulWidget {
  final String content;

  const EditNickNamePage({super.key, required this.content});

  @override
  _EditNickNamePageState createState() => _EditNickNamePageState();
}

class _EditNickNamePageState extends State<EditNickNamePage> {
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;
  bool isSave = false;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
    _textEditingController?.addListener(() {
      if ((_textEditingController?.text.length ?? 0) > 30) {
        _textEditingController?.text =
            _textEditingController?.text.substring(0, 30) ?? "";
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
          ),
          Text(
            Tr.app_details_edit_name.tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: AppConstants.fontsBold,
                fontSize: 16,
                color: Colors.black),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsetsDirectional.only(start: 15, end: 5),
            margin: const EdgeInsetsDirectional.only(
                top: 15, start: 15, end: 15, bottom: 5),
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: const Color(0xFFAC53FB),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.bold),
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                      FilteringTextInputFormatter.deny(RegExp(r'^\s+'))
                    ],
                    decoration: InputDecoration(
                        //border: InputBorder.none,
                        hintText: Tr.app_not_exceed.trArgs(["30"]),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF9341FF))),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEEEEEE))),
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: AppConstants.fontsBold,
                            color: Colors.grey)),
                  ),
                ),
                /* IconButton(
                  onPressed: () {
                    _textEditingController?.text = "";
                  },
                  icon: Image.asset(
                    Assets.imageCancel2,
                    matchTextDirection: true,
                    width: 22,
                    height: 22,
                  ),
                ),*/
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 30,
              top: 20,
            ),
            child: InkWell(
              onTap: () {
                if (_textEditingController?.text != null &&
                    _textEditingController!.text.isNotEmpty) {
                  _focusNode?.unfocus();
                  String? str = _textEditingController?.text
                      .replaceAll(' ', "")
                      .replaceAll('\n', "");
                  logic?.updateUser(nickname: str ?? '');
                  Get.back();
                } else {
                  AppLoading.toast(Tr.app_not_entered.tr);
                }
              },
              child: ShortBaseButton(
                Tr.app_base_confirm.tr,
                isSave: isSave,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
