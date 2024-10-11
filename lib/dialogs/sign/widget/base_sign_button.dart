import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/sign/result/sign_reward.dart';
import 'package:oliapro/entities/sign_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';

class BaseSignButton extends StatelessWidget {
  final SignBean data;
  final bool isToSign;

  final Function(SignBean) onSignBack;

  const BaseSignButton(this.data,
      {super.key, required this.isToSign, required this.onSignBack});

  final TextStyle baseTextStyle = const TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isToSign) {
          Get.back();
          toSign(id: data.id, configId: data.configId, data: data);
        }
      },
      child: Container(
        width: 217,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                matchTextDirection: true,
                image: ExactAssetImage((isToSign == true)
                    ? Assets.signQuickSignBtn
                    : Assets.signSignedBtn))),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          //color: Colors.white60,
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.only(
              top: 2, start: 2, end: 2, bottom: 25),
          child: AutoSizeText(
            (isToSign == true) ? Tr.appSignNow.tr : Tr.app_sign_end.tr,
            maxFontSize: 16,
            minFontSize: 8,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: baseTextStyle,
          ),
        ),
      ),
    );
  }

  toSign({int? id, int? configId, required SignBean data}) async {
    // debugPrint("toSign===>> ${data.toJson()}");
    await Http.instance
        .post<SignBean>("${NetPath.signInDaily}$id/$configId",
            showLoading: true)
        .then((value) {
      if (data.type == 6) {
        data.vipDiamonds = value.vipDiamonds;
      }
    }).whenComplete(() {
      data.signDate = data.todayDate;
      if (data.type == 3 ||
          data.type == 7 ||
          data.type == 9 ||
          data.type == 10) {
        //我的背包有红点提示
        StorageService.to.eventBus.fire(eventBusRefreshMe);
      }
      if (data.type == 3 || data.type == 9) {
        //刷新我的接口
        // StorageService.to.eventBus.fire(eventBusRefreshMe);
      }
      if (data.type == 7) {
        //获取聊天卡，可以去聊天
        UserInfo.to.getMsgCard();
      }
      if (data.type == 8) {
        //抽奖次数增加data.value
        StorageService.to.eventBus.fire(eventBusRefreshMe);
      }
      if (data.type == 10) {
        //获得签到头像
        UserInfo.to.getSignFrame();
      }

      showSignReward(data);
    });

    //onSignBack.call(data);
  }
}
