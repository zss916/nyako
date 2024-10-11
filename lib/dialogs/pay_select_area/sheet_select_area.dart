import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/game/game_dialog_manager.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/utils/app_extends.dart';

///选择
showSelectAreaSheet(List<AreaData> data, Function(AreaData?) func,
    {bool isBot = false}) {
  if (isBot) {
    GameDialogManager.openCountrySelect(data, func);
  } else {
    /* Get.bottomSheet(
        BottomArrowWidget(
          child: MSelectArea(
            data: data,
            func: func,
          ),
          onBack: () => Get.back(),
        ),
        settings: const RouteSettings(name: AppPages.selectAreaSheet),
        isDismissible: true);*/

    Get.dialog(
        MSelectArea(
          data: data,
          func: func,
        ),
        barrierColor: Colors.black45,
        routeSettings: const RouteSettings(name: AppPages.selectAreaSheet),
        barrierDismissible: true);
  }
}

class MSelectArea extends StatefulWidget {
  final List<AreaData> data;
  final Function(AreaData?) func;
  final bool? isBot;
  final CancelFunc? cancelFunc;

  const MSelectArea(
      {Key? key,
      required this.data,
      required this.func,
      this.isBot,
      this.cancelFunc})
      : super(key: key);

  @override
  State<MSelectArea> createState() => _MSelectAreaState();
}

class _MSelectAreaState extends State<MSelectArea> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          if (widget.isBot == true) {
            widget.cancelFunc?.call();
          }
          widget.func.call(null);
        },
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.only(top: 55),
              decoration: const BoxDecoration(
                  color: Color(0xFF312240),
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(16),
                      bottomStart: Radius.circular(16))),
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 10.0,
                children: widget.data
                    .map(
                      (item) => selectItem(widget.func, item),
                    )
                    .toList(),
              ),
            ),
            const Spacer()
          ],
        ));
  }

  Widget selectItem(Function(AreaData?) func, AreaData item) {
    return GestureDetector(
      onTap: () {
        if (mounted) {
          setState(() {
            for (var element in widget.data) {
              element.selected = false;
            }
            item.selected = true;
            widget.func.call(item);
            if (widget.isBot == true) {
              widget.cancelFunc?.call();
            } else {
              Get.back();
            }
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
        decoration: (item.isSelect == true)
            ? const BoxDecoration(
                color: Color(0x26000000),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )
            : BoxDecoration(
                color: const Color(0x26000000),
                border: Border.all(color: const Color(0x4DF447FF), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              margin: const EdgeInsetsDirectional.only(end: 4),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: cachedImage(item.path ?? "", fit: BoxFit.cover),
            ),
            Text(
              item.title ?? "",
              style: TextStyle(
                  color: item.isSelect == true ? Colors.white : Colors.white,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
