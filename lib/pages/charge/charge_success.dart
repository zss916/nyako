import 'package:oliapro/game/game_dialog_manager.dart';

///支付成功
void showRechargeSuccess(
    {required int drawCount,
    required String diamonds,
    required bool isVipOrder,
    bool isBot = true}) {
  GameDialogManager.openRechargeSuccess(
      drawCount: drawCount,
      diamonds: diamonds,
      isVipOrder: isVipOrder,
      isBot: isBot);
}
