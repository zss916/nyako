import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_sign_card_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/cardlist/index.dart';
import 'package:nyako/pages/main/me/mine/widget/avatar_state.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';

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
      height: 230,
      padding: const EdgeInsetsDirectional.only(
          top: 20, start: 10, end: 10, bottom: 10),
      decoration: BoxDecoration(
        color:
            widget.item.isUsed == true ? Colors.white : const Color(0xFFF4F5F6),
        border: widget.item.isUsed == true
            ? Border.all(width: 2, color: const Color(0xFF9341FF))
            : null,
        borderRadius: BorderRadiusDirectional.circular(16),
      ),
      child: Column(
        children: [
          (widget.item.isVipFrame)
              ? Image.asset(
                  Assets.frameVipFrame,
                  width: 95,
                  height: 95,
                  matchTextDirection: true,
                )
              : Image.asset(
                  Assets.frameSignFrame,
                  width: 95,
                  height: 95,
                  matchTextDirection: true,
                ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 5, end: 5),
            width: double.maxFinite,
            child: Text(
              (widget.item.isVipFrame) ? "VIP" : Tr.appDelicateAvatarFrame.tr,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.w500),
            ),
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
              maxFontSize: 13,
              minFontSize: 6,
              style: TextStyle(
                color: const Color(0xFF9B989D),
                fontFamily: AppConstants.fontsRegular,
                fontSize: 13,
              ),
            ),
          ),
          Opacity(
              opacity: widget.item.isUsed == true ? 1 : 0.5,
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
                      color: (widget.item.isUsed == true)
                          ? const Color(0x269341FF)
                          : const Color(0xFFE8E8E8),
                      borderRadius: BorderRadiusDirectional.circular(40)),
                  child: Text(
                    widget.item.isUsed == true
                        ? Tr.appSignHeaderUsed.tr
                        : Tr.appSignHeaderPut.tr,
                    style: TextStyle(
                        color: (widget.item.isUsed == true)
                            ? const Color(0xFF9341FF)
                            : const Color(0xFF9B989D),
                        fontSize: 12,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
