import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/public_tip.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/public/index.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/image_update/app_choose_image_util.dart';
import 'package:oliapro/widget/semantics/label.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

class PublicBody extends StatefulWidget {
  final PublicLogic logic;

  const PublicBody(this.logic, {super.key});

  @override
  State<PublicBody> createState() => _PublicBodyState();
}

class _PublicBodyState extends State<PublicBody> {
  FocusNode focusNode = FocusNode();
  bool isShowEmoji = false;
  double width = (Get.width - 30 - 9 * 2) / 3;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isShowEmoji = false;
        });
      }
    });

    Future.delayed(const Duration(microseconds: 500), () {
      showPublicTipDialog();
    });
  }

  @override
  void dispose() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsetsDirectional.only(top: 60),
      child: GetBuilder<PublicLogic>(
          assignId: true,
          init: PublicLogic(),
          builder: (logic) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    width: double.maxFinite,
                    child: TextField(
                      controller: logic.ctl,
                      cursorColor: Colors.black,
                      onTap: () {
                        if (focusNode.hasFocus) {
                          focusNode.unfocus();
                        }
                      },
                      expands: false,
                      maxLines: null,
                      minLines: 6,
                      keyboardAppearance: Brightness.dark,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(200),
                      ],
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      onSubmitted: (text) {
                        //focusNode.unfocus();
                      },
                      onChanged: (str) {
                        logic.lengthRx.value = str.length;
                      },
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        filled: true,
                        isCollapsed: true,
                        fillColor: Colors.transparent,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.all(20.0),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            )),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            )
                            //
                            ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            )
                            //
                            ),
                        hintText: Tr.app_message_send_input.tr,
                      ),
                    ).onLabel(label: SemanticsLabel.text),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerEnd,
                    margin: const EdgeInsetsDirectional.only(end: 15),
                    child: Obx(() {
                      return Text(
                        "${logic.lengthRx.value}/200",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      );
                    }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 15, top: 22),
                    child: _gridViewImg(),
                  ),
                ],
              ),
            );
          }),
    );
  }

  ///url
  Widget imgItem(int index, String path) {
    return Container(
      width: 89,
      height: 89,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(right: 7),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: cachedImage(path, width: 89, height: 89),
          ),
          Positioned(
              top: 4,
              right: 3,
              child: GestureDetector(
                onTap: () => widget.logic.reduceImg(index),
                child: Image.asset(
                  Assets.imgCloseDialog,
                  width: 22,
                  height: 22,
                ),
              ))
        ],
      ),
    );
  }

  Widget addImage() {
    return SizedBox(
      height: width,
      width: width,
      child: InkWell(
        onTap: () {
          //可以优化多张图片选择
          AppChooseImageUtil(type: 1, callBack: widget.logic.upLoadCallBack)
              .openChooseDialog();
        },
        child: Image.asset(
          Assets.imgFollow,
          height: width,
          width: width,
        ),
      ).onLabel(label: SemanticsLabel.append),
    );
  }

  Widget _gridViewImg() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
        ),
        itemCount: widget.logic.pics.length,
        itemBuilder: (context, index) {
          if (widget.logic.pics[index] == widget.logic.tag) {
            return addImage();
          } else {
            return gridImgItem(index, widget.logic.pics[index]);
          }
        });
  }

  Widget gridImgItem(int index, String path) {
    return Container(
      width: width,
      height: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: cachedNetImage(path, width: width, height: width),
          ),
          PositionedDirectional(
              top: 4,
              end: 4,
              child: GestureDetector(
                onTap: () => widget.logic.reduceImg(index),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadiusDirectional.circular(0)),
                  child: Image.asset(
                    Assets.imgCloseDialog,
                    width: 20,
                    height: 20,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
