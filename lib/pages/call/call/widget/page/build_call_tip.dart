import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/utils/app_extends.dart';

class BuildCallTip extends StatelessWidget {
  final String portrait;

  final String nickName;

  final String id;

  final Widget title;

  final Widget submit;

  final Function onCancel;

  final Function onSubmit;

  const BuildCallTip(
      {super.key,
      required this.portrait,
      required this.nickName,
      required this.id,
      required this.title,
      required this.submit,
      required this.onCancel,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFFE6D7FE), Color(0xFFFED2E3)]),
              borderRadius: BorderRadiusDirectional.circular(20)),
          margin: const EdgeInsetsDirectional.only(
              start: 10, end: 10, top: 30, bottom: 25),
          width: 355,
          //height: 154,
          padding: const EdgeInsetsDirectional.only(bottom: 30),
          constraints: const BoxConstraints(minHeight: 154),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsetsDirectional.only(
                        end: 12, top: 12, start: 12),
                    padding: const EdgeInsetsDirectional.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, color: Colors.white)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: cachedImage(portrait),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsetsDirectional.only(top: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          nickName,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: AppConstants.fontsBold,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          id,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: AppConstants.fontsRegular,
                              color: const Color(0x99642A4B),
                              fontSize: 13),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 10),
                    child: Image.asset(
                      Assets.iconLove,
                      matchTextDirection: true,
                      width: 60,
                      height: 60,
                    ),
                  )
                ],
              ),
              Container(
                constraints: const BoxConstraints(minHeight: 48),
                margin: const EdgeInsetsDirectional.only(
                    top: 12, start: 12, end: 12),
                width: double.maxFinite,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFECE1F7),
                        ]),
                    borderRadius: BorderRadiusDirectional.circular(12)),
                child: title,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                onCancel.call();
              },
              child: Container(
                width: 115,
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 12, horizontal: 5),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(30)),
                child: Text(
                  Tr.app_base_cancel.tr,
                  style: TextStyle(
                      color: Color(0xFF9341FF),
                      fontSize: 15,
                      fontFamily: AppConstants.fontsRegular,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              width: 28,
            ),
            GestureDetector(
              onTap: () {
                onSubmit.call();
              },
              child: Container(
                width: 115,
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 12, horizontal: 5),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Color(0xA69341FF), blurRadius: 5)
                    ],
                    color: const Color(0xFF9341FF),
                    borderRadius: BorderRadiusDirectional.circular(30)),
                child: submit,
              ),
            ),
          ],
        )
      ],
    );
  }
}
