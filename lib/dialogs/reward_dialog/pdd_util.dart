import 'package:oliapro/dialogs/reward_dialog/pdd2.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/http/index.dart';

class PddUtil {
  PddUtil._internal();

  static final PddUtil _instance = PddUtil._internal();

  static PddUtil get instance => _instance;

  //支付渠道
  void channelPayOpen() {
    Pdd2.paymentBoxShow();
  }

  void channelPayClose() {
    Pdd2.paymentBoxClose();
  }

  HostDetail? pddDetail;

  //主播详情
  void anchorDetailsInit({required String anchorId}) {
    Pdd2.openAnchorDetail(() async {
      await Http.instance.post<HostDetail>(NetPath.upDetailApi + anchorId,
          data: {'vipVideo': 1}, errCallback: (err) {
        pddDetail = null;
      }).then((value) {
        pddDetail = value;
      });
      return pddDetail;
    });
  }

  void anchorDetailsClose() {
    Pdd2.closeAnchorDetail();
  }

  //充值open
  void chargeDialogOpen() {
    Pdd2.topUpBoxShow();
  }

  //充值close
  void chargeDialogClose() {
    Pdd2.topUpBoxClose();
  }

  //开启中奖计时器
  void mainInit() {
    Pdd2.userBalanceChangeStart();
  }

//关掉中奖计时器
  void mainStop() {
    Pdd2.userBalanceChangeStop();
  }

  //余额变动
  void socketBalanceChange() {
    Pdd2.userBalanceChangeStart();
  }

  //点击支付渠道
  Future<void> clickPayChannel() async {
    await Pdd2.paymentBoxGoPay();
  }
}
