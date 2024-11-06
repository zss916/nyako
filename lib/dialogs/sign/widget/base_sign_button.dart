import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/sign/result/sign_reward.dart';
import 'package:nyako/entities/sign_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';

class BaseSignButton extends StatelessWidget {
  final SignBean data;
  final bool isToSign;

  final Function(SignBean) onSignBack;

  const BaseSignButton(this.data,
      {super.key, required this.isToSign, required this.onSignBack});

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
        width: 265,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                matchTextDirection: true,
                image: ExactAssetImage((isToSign == true)
                    ? Assets.signNyakoQuickSignBtn
                    : Assets.signNyakoSignedBtn))),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          //color: Colors.white60,
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.only(
              top: 4, start: 2, end: 2, bottom: 0),
          child: AutoSizeText(
            (isToSign == true) ? Tr.appSignNow.tr : Tr.app_sign_end.tr,
            maxFontSize: 16,
            minFontSize: 8,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: (isToSign == true)
                    ? const Color(0xFF773913)
                    : const Color(0xFF666666),
                fontSize: 16,
                fontFamily: AppConstants.fontsBold,
                fontWeight: FontWeight.bold),
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
