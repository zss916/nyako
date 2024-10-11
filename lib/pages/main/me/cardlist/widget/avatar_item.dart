import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_sign_card_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/cardlist/index.dart';
import 'package:oliapro/pages/main/me/mine/widget/avatar_state.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';

class AvatarItem extends StatefulWidget {
  final AppLiveSignCard item;
  final PropLogic logic;
  const AvatarItem(this.item, this.logic, {super.key});

  @override
  State<AvatarItem> createState() => _AvatarItemState();
}

class _AvatarItemState extends State<AvatarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 216,
      padding: const EdgeInsetsDirectional.only(
          top: 10, start: 10, end: 10, bottom: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [Color(0xFF2B1A36), Color(0xFF2B1A36)]),
        borderRadius: BorderRadiusDirectional.circular(16),
      ),
      child: Column(
        children: [
          (widget.item.isVipFrame)
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      Assets.frameVipFrame,
                      width: 110,
                      height: 110,
                      matchTextDirection: true,
                    ),
                    PositionedDirectional(
                        start: 0,
                        top: 0,
                        child: Image.asset(
                          Assets.imgIconVip,
                          width: 32,
                          height: 16,
                        ))
                  ],
                )
              : Image.asset(
                  Assets.frameSignFrame,
                  width: 110,
                  height: 110,
                  matchTextDirection: true,
                ),
          const Spacer(),
          Container(
            alignment: AlignmentDirectional.center,
            margin: const EdgeInsetsDirectional.only(top: 2, bottom: 10),
            child: AutoSizeText(
              (widget.item.isVipFrame)
                  ? widget.item.showEndTime ?? "--"
                  : widget.item.avatarEndTime(),
              maxLines: 1,
              maxFontSize: 14,
              minFontSize: 6,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          Opacity(
              opacity: widget.item.isUsed == true ? 0.5 : 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (widget.item.isUsed == false) {
                      int type = (widget.item.isVipFrame)
                          ? AvatarStatus.vip.index
                          : AvatarStatus.sign.index;
                      //debugPrint("AvatarStatus===>>>  ${type}");
                      AvatarStatusHand.setAvatarType(type: type);
                      StorageService.to.eventBus.fire(eventBusRefreshMe);
                      widget.logic.hand(widget.item.propId ?? 0);
                    }
                    widget.item.isUsed = true;
                  });
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  height: 35,
                  width: double.maxFinite,
                  margin: const EdgeInsetsDirectional.only(
                      top: 0, start: 12, end: 12, bottom: 5),
                  decoration: BoxDecoration(
                      gradient: AppColors.btnGradient,
                      borderRadius: BorderRadiusDirectional.circular(40)),
                  child: Text(
                    widget.item.isUsed == true
                        ? Tr.appSignHeaderUsed.tr
                        : Tr.appSignHeaderPut.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
