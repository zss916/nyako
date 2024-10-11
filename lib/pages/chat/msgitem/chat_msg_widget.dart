import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/mine/widget/avatar_state.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_voice_player.dart';

import '../../../common/app_constants.dart';
import '../../../database/entity/app_msg_entity.dart';
import 'chat_msg_wrapper.dart';

class LianChatMsgHer extends StatelessWidget {
  final Widget child;
  final ChatMsgWrapper wrapper;
  final bool? isOnline;

  const LianChatMsgHer(
      {super.key,
      required this.child,
      required this.wrapper,
      this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    var time = DateTime.fromMillisecondsSinceEpoch(wrapper.date);
    var str = DateFormat('MM.dd HH:mm').format(time);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          if (wrapper.showTime)
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              child: Text(
                str,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (wrapper.herId == AppConstants.systemId ||
                      wrapper.herId == AppConstants.serviceId)
                  ? Image.asset(
                      Assets.imgSystemIcon,
                      width: 40,
                      height: 40,
                      matchTextDirection: true,
                    )
                  : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        AppAudioPlayer().stop();
                        ARoutes.toAnchorDetail(wrapper.herId);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(35),
                        child: cachedImage(wrapper.her?.portrait ?? "",
                            width: 40, height: 40, type: 100),
                      ),
                    ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: child,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LianChatMsgMe extends StatelessWidget {
  final Widget child;
  final ChatMsgWrapper wrapper;

  const LianChatMsgMe({super.key, required this.child, required this.wrapper});

  @override
  Widget build(BuildContext context) {
    var time = DateTime.fromMillisecondsSinceEpoch(wrapper.date);
    var str = DateFormat('MM.dd HH:mm').format(time);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          if (wrapper.showTime)
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              child: Text(
                str,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 30),
              if (wrapper.msgEntity.sendState == 1 &&
                  wrapper.msgEntity.msgEventType == MsgEventType.sending)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    backgroundColor: Color(0x26FF497E),
                    // value: 0.2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFFF497E)),
                  ),
                ),
              if (wrapper.msgEntity.sendState == 2)
                const Icon(
                  Icons.error_outline,
                  color: Color(0xFFFF497E),
                  size: 25,
                ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: child,
              ),
              const SizedBox(
                width: 10,
              ),
              // buildContent(state: AvatarStatus.sign.index)
              buildContent(state: AvatarStatusHand.getType())
            ],
          ),
        ],
      ),
    );
  }

  Widget buildContent({int state = 0}) {
    return switch (state) {
      _ when state == AvatarStatus.vip.index => Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              width: 46,
              height: 46,
              foregroundDecoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      matchTextDirection: true,
                      image: ExactAssetImage(
                        Assets.frameVipFrame,
                      ))),
              child: Center(
                child: Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsetsDirectional.only(bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(35),
                    child: cachedImage(
                      UserInfo.to.userPortrait,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      _ when state == AvatarStatus.sign.index => Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 46,
              height: 46,
              foregroundDecoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      matchTextDirection: true,
                      image: ExactAssetImage(
                        Assets.frameSignFrame,
                      ))),
              child: Container(
                width: 32,
                height: 32,
                alignment: AlignmentDirectional.center,
                child: ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(35),
                  child: cachedImage(
                    UserInfo.to.userPortrait,
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      _ when state == AvatarStatus.common.index => Container(
          margin: const EdgeInsetsDirectional.only(top: 0),
          child: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(35),
            child: cachedImage(
              UserInfo.to.userPortrait,
              width: 32,
              height: 32,
            ),
          ),
        ),
      _ => Container(
          margin: const EdgeInsetsDirectional.only(top: 0),
          child: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(35),
            child: cachedImage(
              UserInfo.to.userPortrait,
              width: 32,
              height: 32,
            ),
          ),
        ),
    };
  }
}
