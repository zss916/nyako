import 'package:agora_rtm/agora_rtm.dart';

const eventBusRefreshMe = 'eventBusRefreshMe';
const eventBusRefreshMeFromCache = 'eventBusRefreshMeFromCache';
const vipRefresh = 'vipRefresh';

class EventRtmCall {
  LocalInvitation? invite;
  RemoteInvitation? herInvite;
  // 1 我的呼叫被接受 2 我的呼叫被拒绝 3对方呼叫取消
  int type;
  EventRtmCall(this.type, {this.invite, this.herInvite});
}

class EventMsgClear {
  // 0 都设为已读，1清空所有,3清空某主播
  int type;
  EventMsgClear(this.type);
}

class EventCommon {
  // 0电话涉黄
  // 1拉黑
  // 2举报
  int eventType;
  String herId;
  EventCommon(this.eventType, this.herId);
}

class EventOrderResult {
  int eventType;
  EventOrderResult(this.eventType);
}

class EventCanCallStateChange {
  // 0余额变成可以打电话
  // 1余额变成不能打电话
  // 2视频体验卡 有了
  // 3视频体验卡 没有了
  int eventType;
  EventCanCallStateChange(this.eventType);
}

class EventUnRead {
  int unReadNum;

  EventUnRead(this.unReadNum);
}
