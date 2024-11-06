import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_draw_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/widget/base_button2.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_extends.dart';

void toDrawDialog(DrawData data) {
  Get.dialog(DrawDialog(data),
      barrierDismissible: false,
      barrierColor: Colors.black87,
      routeSettings: const RouteSettings(name: AppPages.drawResultDialog));
}

Widget getImg(int drawType, String icon) {
  switch (drawType) {
    case 0:
      return Image.asset(
        Assets.lotteryLotteryEmpty,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    case 1:
      return Image.asset(
        Assets.lotteryLotteryDiamond,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    case 2:
      return Image.asset(
        Assets.lotteryLotteryKing,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    case 3:
      return Image.asset(
        Assets.lotteryLotteryAddCard,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    case 5:
      return Image.asset(
        Assets.lotteryLotteryCallCard,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    default:
      return cachedImage(
        icon,
        width: 36,
        height: 36,
      );
  }
}

class DrawDialog extends StatefulWidget {
  final DrawData data;

  const DrawDialog(this.data, {super.key});

  @override
  State<DrawDialog> createState() => _DrawDialogState();
}

class _DrawDialogState extends State<DrawDialog> {
  @override
  void initState() {
    super.initState();
    StorageService.to.eventBus.fire(eventBusRefreshMe);
    StorageService.to.eventBus.fire(vipRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          if (widget.data.drawType != 0)
            PositionedDirectional(
                top: 0,
                start: 0,
                end: 0,
                child: Image.asset(
                  Assets.iconDrawResultBg,
                  matchTextDirection: true,
                )),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 30),
            margin:
                const EdgeInsetsDirectional.only(top: 160, start: 40, end: 40),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: AlignmentDirectional.bottomStart,
                    end: AlignmentDirectional.topEnd,
                    colors: [Colors.white, Color(0xFFFFFBC1)]),
                borderRadius: BorderRadiusDirectional.circular(30)),
            child: buildContent(widget.data.drawType ?? 0, widget.data),
          )
        ],
      ),
    );
  }

  Widget buildContent(int type, DrawData data) {
    return switch (type) {
      _
          when (type == 0 ||
              type == 1 ||
              type == 2 ||
              type == 3 ||
              type == 4 ||
              type == 5) =>
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 30),
              child: Text(
                (widget.data.drawType != 0)
                    ? "${Tr.app_congratulations_get.tr} ${widget.data.getResult2()}"
                    : Tr.app_draw0.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getImg(widget.data.drawType ?? 0, widget.data.icon ?? ""),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 3),
                  child: Text(
                    data.getContent2(),
                    style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9341FF)),
                  ),
                )
              ],
            ),
            type == 0
                ? const SizedBox(
                    height: 30,
                  )
                : Container(
                    margin:
                        const EdgeInsetsDirectional.only(top: 18, bottom: 30),
                    child: Image.asset(
                      Assets.lotteryLotteryIc,
                      width: 200,
                      height: 10,
                    ),
                  ),
            GestureDetector(
              onTap: () => Get.back(),
              child: BaseButton2(Tr.app_base_confirm.tr),
            )
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
