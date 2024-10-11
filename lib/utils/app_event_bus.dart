import 'package:event_bus/event_bus.dart';

class AppEventBus {
  static late final EventBus eventBus = EventBus();
}

///关注刷新
class FollowEvent {
  String? anchorId;
  bool? isFollowed; //1已经关注，0未关注
  FollowEvent({this.anchorId, this.isFollowed});
}

///刷新我的动态
class MyMomentEvent {
  MyMomentEvent();
}

///举报刷新
class ReportEvent {
  int type;
  String? momentId;
  String? discoverIndex;
  String? mid;

  ReportEvent(this.type, {this.momentId, this.discoverIndex, this.mid});
}

///拉黑
class BlackEvent {
  String? uid;
  BlackEvent({required this.uid});
}

enum ReportEnum {
  anchorDetail,
  moment,
  chat,
  discover,
  settlement,
  anchorDetailMoment,
  momentDetail,
  setting,
  match,
  anchorDetailImage,
}

///回到首页
class BackHomeEvent {
  BackHomeEvent();
}

///打开发送礼物弹窗
class OpenSendGiftEvent {
  OpenSendGiftEvent();
}

///game
class GameUpdateEvent {
  GameUpdateEvent();
}

///test
class TestEvent {
  TestEvent();
}

class BalanceEvent {
  int diamond;
  BalanceEvent(this.diamond);
}

///泡泡游戏奖励
class BubbleAwardEvent {
  BubbleAwardEvent();
}
