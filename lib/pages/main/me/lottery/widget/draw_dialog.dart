import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_draw_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/widget/base_button2.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_extends.dart';

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
        Assets.lotteryDrawEmpty,
        width: 255,
        height: 146,
        fit: BoxFit.cover,
      );
    case 1:
      return Image.asset(
        Assets.lotteryDrawDiamond,
        width: 255,
        height: 146,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    case 2:
      return Image.asset(
        Assets.lotteryDrawKing,
        width: 255,
        height: 146,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    case 3:
      return Image.asset(
        Assets.lotteryDrawDiamondCard,
        width: 255,
        height: 146,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    case 5:
      return Image.asset(
        Assets.lotteryDrawCallCard,
        width: 255,
        height: 146,
        fit: BoxFit.cover,
        matchTextDirection: true,
      );
    default:
      return cachedImage(
        icon,
        width: 255,
        height: 146,
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
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
            height: 280,
            width: 320,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: AlignmentDirectional.bottomStart,
                    end: AlignmentDirectional.topEnd,
                    colors: [
                      Color(0xFF8940FF),
                      Color(0xFFD34BFD),
                    ]),
                borderRadius: BorderRadiusDirectional.circular(30)),
            margin: const EdgeInsetsDirectional.only(top: 0),
            padding: const EdgeInsetsDirectional.only(
                start: 20, end: 20, bottom: 30, top: 80),
            child: buildContent(widget.data.drawType ?? 0)),
        SizedBox(
            height: 280 + 150,
            width: 320,
            child: Column(
              children: [
                getImg(widget.data.drawType ?? 0, widget.data.icon ?? "")
              ],
            )),
      ],
    );
  }

  Widget buildContent(int type) {
    return switch (type) {
      _ when type == 0 => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            AutoSizeText(widget.data.getResult(),
                maxLines: 3,
                maxFontSize: 20,
                minFontSize: 20,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.back(),
              child: BaseButton2(Tr.app_base_confirm.tr),
            )
          ],
        ),
      _ when (type == 1 || type == 2 || type == 3 || type == 4 || type == 5) =>
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.data.drawType != 0)
              Container(
                margin: const EdgeInsetsDirectional.only(top: 0),
                child: Text(
                  Tr.app_congratulations_get.trArgs(['']),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const Spacer(),
            AutoSizeText(widget.data.getResult(),
                maxLines: 3,
                maxFontSize: 15,
                minFontSize: 15,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.back(),
              child: BaseButton2(Tr.app_base_confirm.tr),
            )
          ],
        ),
      _ => const SizedBox(
          width: 18,
          height: 18,
        ),
    };
  }

  /*FractionallySizedBox(
  widthFactor: 1.0,
  heightFactor: 0.7,
  child: ,
  )*/
}
