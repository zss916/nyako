import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/widget/transfer_b.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_extends.dart';

class SelectArea extends StatefulWidget {
  final List<AreaData> data;
  final Function(AreaData?) func;

  SelectArea({Key? key, required this.data, required this.func})
      : super(key: key);

  @override
  State<SelectArea> createState() => _SelectAreaState();
}

class _SelectAreaState extends State<SelectArea> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              margin:
                  const EdgeInsetsDirectional.only(top: 74, start: 12, end: 12),
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.only(
                    end: 0, start: 0, bottom: 10, top: 10),
                decoration: const BoxDecoration(
                  color: Color(0xFF5F4A73),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 5.0,
                  children: widget.data
                      .map(
                        (item) => selectItem(widget.func, item),
                      )
                      .toList(),
                ),
              ),
            ),
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                widget.func.call(null);
                Get.back();
              },
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.only(top: 0),
                child: Column(
                  children: [
                    Transferb(
                        turn: 2,
                        child: Image.asset(
                          Assets.imgBottomArrow,
                          matchTextDirection: true,
                          width: 42,
                          height: 10,
                        ))
                  ],
                ),
              ),
            ))
          ],
        ));
  }

  Widget selectItem(Function(AreaData?) func, AreaData item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (item.showCanChoose) {
            for (var element in widget.data) {
              element.isSelect = false;
            }
            item.isSelect = true;
            StorageService.to.saveAreaCode(item.areaCode ?? -1);
            AppEventBus.eventBus.fire(item);
            func.call(item);
            Get.back();
          } else {
            if (!AppConstants.isFakeMode) {
              sheetToVip(path: ChargePath.recharge_choose_area, index: 3);
            }
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsetsDirectional.only(
            start: 5, end: 5, top: 3, bottom: 3),
        decoration: (item.isSelect == true && item.showCanChoose)
            ? const BoxDecoration(
                border: GradientBoxBorder(
                    gradient: LinearGradient(colors: [
                      Color(0xFF7B58F5),
                      Color(0xFFED63F9),
                    ]),
                    width: 1),
                // border: Border.all(color: const Color(0x4DF447FF), width: 1),
                color: Color(0x26000000),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )
            : BoxDecoration(
                color: const Color(0x26000000),
                border: Border.all(color: Colors.transparent, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              margin: const EdgeInsetsDirectional.only(end: 2),
              clipBehavior: Clip.hardEdge,
              foregroundDecoration: item.showCanChoose
                  ? null
                  : const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                          image: AssetImage(Assets.finalCountryLock))),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: cachedImage(item.path ?? "", fit: BoxFit.cover),
              ),
            ),
            Text(
              item.title ?? "--",
              style: (item.isSelect == true && item.showCanChoose)
                  ? const TextStyle(color: Colors.white)
                  : const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
