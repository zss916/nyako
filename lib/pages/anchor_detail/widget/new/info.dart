import 'package:flutter/material.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/state_widget.dart';
import 'package:oliapro/utils/app_extends.dart';

class Info extends StatelessWidget {
  HostDetail data;
  AnchorDetailLogic? logic;

  Info(this.data, {super.key, this.logic});

  @override
  Widget build(BuildContext context) {
    //debugPrint("Info ===>>> ${data.lineState()}");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 3),
              child: data.isOnline == null
                  ? const SizedBox.shrink()
                  : StateWidget(data.lineState(), "• ${data.stateStr}"),
            ),
            data.birthday == null
                ? const SizedBox.shrink()
                : Container(
                    width: 40,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.only(
                        top: 2, bottom: 2, left: 6, right: 6),
                    decoration: const BoxDecoration(
                        color: AppColors.colorFF579D,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Assets.imgSmallWoman,
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          data.showBirthday,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        )
                      ],
                    ),
                  ),
            data.area == null
                ? const SizedBox.shrink()
                : Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.only(
                        top: 2, bottom: 2, left: 5, right: 5),
                    decoration: const BoxDecoration(
                        color: Color(0x1AFF890E),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: cachedImage(data.area?.path ?? '',
                              width: 15, height: 15),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(start: 2),
                          child: Text(
                            data.area?.title ?? "--",
                            style: const TextStyle(
                                color: Color(0xFFFF890E),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        GestureDetector(
          onTap: () {
            logic?.copyId();
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsetsDirectional.only(
                top: 2, bottom: 2, start: 6, end: 0),
            decoration: const BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text(
              "ID:${data.username ?? "--"}",
              style: const TextStyle(color: Color(0xFFBAAEB7), fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
