part of 'index.dart';

class NetPath {
  // 正式
  static const String app = "olialite";
  static String socketBaseUrl = "wss://api.$app.org/socket";
  static String configBaseUrl = "https://api.$app.org";
  static String baseUrl = "$configBaseUrl/api";

  static String getConfigBaseUrl() {
    return configBaseUrl;
  }

  static String getSocketBaseUrl() {
    return socketBaseUrl;
  }

  static String getBaseUrl() {
    return baseUrl;
  }

  static const String configApi = "/app/config";
  static const String configApiV2 = "/app/configV2";
  static const String facebookLoginApi = "/login/facebook";
  static const String googleLoginApi = "/login/google";
  static const String appleLoginApi = "/login/apple";
  static const String getTransationsV2Api = "/app/loadTranslateConfigV2/0";
  static const String loginOutApi = "/login/userLogout";
  //注销账号
  static const String deleteCurrentAccount = "/user/deleteUser";
  //阿里云上传凭证
  static const String aliOssApi = "/user/storage/upload/apply";
  static const String updateUserInfoApi = "/user/updateUserDetails";
  static const String bindGoogleApi = "/user/bindGoogle";
  static const String visitorLoginApi = "/app/register";
  static const String changePasswordApi = "/user/changePassword";
  //主播列表 关注的主播列表...
  static const String upListApi = "/anchor/findAnchors/";
  static const String commandUpListApi = "/anchor/findRecommendAnchors/";
  static const String upDetailApi = "/anchor/findAnchorDetails/";
  static const String followUpApi = "/follow/saveAttention/";
  static const String followUpListApi = "/follow/getFollowList/";
  // 获取指定数量主播
  static const String getMatchUpListApi = "/anchor/getRandAnchors/";
  // 获取10个主播头像
  static const String getAnchorPortraits = "/anchor/getAnchorPortraits/";
  // 限制次数匹配1个主播
  static const String matchOneAnchorLimit = "/anchor/matchOneAnchorLimit";
  // 审核模式数据接口
  static const String auditModeData = "/app/auditModeData/0";
  //用户信息
  static const String userInfoApi = "/user/getUserDetails";
  // 礼物列表 不包含vip礼物
  static const String giftListApi = "/gift/getList";
  // 礼物列表 包含vip礼物
  static const String giftAllListApi = "/gift/allList";

  @Deprecated("废弃")
  static const String sendGiftApi = "/gift/send";

  //钻石赠送礼物/gift/sendReal   （正常发送礼物使用）
  static const String sendDiamondGiftApi = "/gift/sendReal";

  //送背包的礼物 /gift/sendPackage  （只有在背包里送礼才用这个）
  static const String sendPackageGiftApi = "/gift/sendPackage";

  //获取用户简要信息
  static const String simpleUserInfoApi = "/anchor/getChatUserInfo/";
  //获取签到配置
  static const String signConfigApi = "/signin/getConfigs";
  //用户进行签到
  static const String userSignApi = "/signin/user/signIn";
  //创建频道
  static const String createCallApi = "/call/createCall/";
  static const String createAIBCallApi = "/call/createAIBCall/";
  //获取进入频道的token
  static const String agoraTokenApi = "/call/joinCallV2/";
  //对方加入该频道成功后通知服务器开始计时计费
  static const String callReadyApi = "/call/readyCall/";
  //通话结束计费结果
  static const String endCallApi = "/call/endCall/";
  //用户端每计时一分钟时通知扣用户钻石
  static const String refreshCallApi = "/call/refreshCallV2/";
  //匹配主播
  static const String matchUpsApi = "/anchor/matchAnchors";
  static const String matchOneAnchor = "/anchor/matchOneAnchor";
  //AIB获取主播云录制视频
  static const String upCloudVideoApi = "/anchor/getAnchorVideo";
  //接听AIB视频后使用一张体验卡
  static const String useCardByAIBApi = "/user/callCardDeduction";
  //RTM消息转发
  static const String rtmServerSendApi = "/user/sendVipMsg";
  //searchup
  static const String searchUpApi = "/anchor/getByUsername/";
  //blacklistaction
  static const String blacklistActionApi = "/blacklist/pullBlack/";

  //blacklistaction
  static const String blacklistApi = "/blacklist/getListByUser";
  static const String callListApi = "/call/callList";

  //sensitive
  static const String sensitiveWordsApi = "/sensitive/getSensitiveWords";

  //report
  static const String reportUpApi = "/feedback/submitReport";

  //tools
  static const String toolsApi = "/prop/propGroups";

  //refuseCall 用户拒绝主播通话后调用接口
  static const String refuseCallApi = "/call/refuseCall";
  static const String refuseAIBCall = "/call/refuseAIBCall/";

  //cancelCall 用户取消自己的视频申请后调用接口
  static const String cancelCallApi = "/call/cancelCall";

  // 没有频道的通话统计 /appCallStatistics/{raiseType}/{statisticsType}
  // raiseType 0.正常唤起 1.AI唤起
  // statisticsType 1 呼叫 2 客户端忙线 3 用户被叫拒绝 4 用户被叫超时 5 用户余额不足 6 用户被叫对方取消 7 用户连接异常

  // raiseType 0.正常唤起 1.AI唤起
  // statisticsType 1 呼叫 2 客户端忙线 3 用户被叫拒绝 4 用户被叫超时
  // 5 用户余额不足 6 用户被叫对方取消 7 用户连接异常
  static const String appCallStatistics = "/call/appCallStatistics";

  //消费明细
  static const String costListApi = "/user/getBalanceDetails/";

  //支付商品列表
  static const String payListApi = "/channelpay/getChannelPayByApp";

  //折扣商品
  // static const String discountProductApi = "/channelpay/getDiscountProduct";
  static const String discountProductApiV2 =
      "/channelpay/getDiscountProduct/v2";

  //折扣商品  1.快捷充值，2.充值中心，3.vip
  // static const String getCompositeProduct = "/channelpay/getCompositeProduct/";
  static const String getCompositeProduct2 = "/p/getCompositeProduct/";

  // VIP商品
  static const String getVipProduct = "/channelpay/getVipProduct";

  // VIP 每天领取钻石
  static const String getVipFreeDiamond = '/signin/vip/signIn';

  //创建订单
  //static const String createOrderApi = "/order/createOrder";
  static const String createOrderApi2 = "/order/createOrder/v2";
  //订单列表
  static const String orderListApi = "/order/orderList";

  //屏蔽消息扣费接口
  // static const String costMsgFeeApi = "/user/sendMsgDeduction";
  static const String costMsgFeeApi =
      "/user/sendVipMsgDeduction"; // 新接口 只有vip发消息

  //banner
  static const String bannerApi = "/banner/getBanners";

  //AIA 接通或者挂断
  static const String hanAIAApi = "/robot/continueRobotMsg";

  //用户回复了机器人消息
  static const String applyRobotApi = "/robot/replyRobotMsg/";

  //初始化机器人消息
  static const String initRobotApi = "/robot/initRobotMsg";

  //谷歌订单回调
  static const String googleNotifyApi = "/notify/googlePay/notify";

  //苹果订单回调
  static const String appleNotifyApi = "/notify/iap/notify";

  //上传成功订单日志
  static const String uploadLogApi = "/app/aol/upload/log";

  //上传成功订单日志
  static const String getOrderStatusApi = "/order/getOrderStatus";

  //app上传发送敏感词记录
  static const String uploadSensitiveRecord =
      "/sensitive/uploadSensitiveRecord";

  //重新获取RTM Token
  static const String genRtmToken = "/user/genRtmToken";

  // 重置用户状态为在线
  static const String resetOnline = "/user/resetOnline";

  // 设置用户已评分
  static const String updateRatedApp = "/user/updateRatedApp";

  // 上传用户归因数据
  static const String attributionData = "/user/upload/attributionData";

  // 账号登录
  static const String accountLogin = "/login/userLogin";

  // 账号注册
  static const String auditModeRegister = "/app/auditModeRegister";

  // AIA视频回调 1.已收到，2.已弹窗
  static const String aiaVideoCallbackApi = "/robot/aiaVideoCallback";

  // AIB视频回调 1.已收到，2.已弹窗 -1丢掉
  static const String aibCallbackApi = "/robot/aibCallback";

  //等级规则/范围/奖品接口
  static const String levelRuleApi = "/app/getByRankConfigByAreaCode";

  //领取奖品接口
  static const String getLevelUpdateGiftApi = "/user/receiveRankRewards";

  //获取翻译文案
  static const String getTransationsApi = "/app/loadTranslateConfig/0";

  // 通话鉴黄不再提醒
  static const String noLongerReminds = "/call/noLongerReminds";

  // 获取s3上传url
  static const String s3UploadUrl = "/user/s3/storage/upload/pre-signed";

  // firebase
  static const String updateFirebaseToken = "/user/syncUserExtra/";

  ///推送点击回传
  static const String clickFirebasePush = "/user/push/statistics/";

  // 用户端动态列表
  static const String getMoments = "/moment/user/page";
  static const String getMoments2 = "/moment/newest/page";

  // 对动态点赞
  static const String momentsPraise = "/moment/praise/";
  static const String momentsPraiseCancel = "/moment/praise/cancel/";

  // 保存审核内容
  static const String saveReviewContent = "/review/saveReviewContent";

  // /review/getLinkContent/$userId/-1
  static const String getLinkContent = "/review/getLinkContent/";
  static const String delContent = "/review/delContent/";

  // 随机返回一条动态
  static const String momentRand = "/moment/rand";
  static const String contributeList = "/ranking/getExpendRanking/";
  static const String bindInviteCode = "/user/bindInviteCode/";
  static const String getInviteInfo = "/user/getInviteInfo/";
  static const String getBalanceDetails = "/user/getBalanceDetails/";
  static const String getDrawConfig = "/draw/getConfig/";

  // 充值抽奖
  static const String rechargeDraw = "/draw/rechargeDraw/";
  static const String getGiftDetail = "/gift/getOne/";

  // 获取广告
  static const String getAdSpots = "/adSpots/getAdSpots";

  // 上传广告点击事件
  static const String adSpotsCallBack = "/adSpots/callback/";

  static const String getDrawUser = "/draw/getDrawUser/";

  ///获取 aib 配置
  static const String getAibConfig = "/robot/getAibConfig";

  ///获取 aib 主播信息
  static const String getAibAnchor = "/robot/getAibAnchor";
  static const String getAivAnchor = "/robot/getAivAnchor";

  // 支付选择国家
  // static const String getPayCountry = "/channelpay/getPayCountry";
  static const String getPayCountry2 = "/p/getPayCountry";
  // static const String getCountryProduct = "/channelpay/getCountryProduct";
  static const String getCountryProduct2 = "/p/getCountryProduct";

  ///森林舞会规则
  static const String playWheelRule = "/game/forestHelp";

  ///森林舞会下注
  static const String playWheelChipApi = "/game/forestBet";

  ///游戏埋点
  static const String gameProbe = "/game/probe";

  ///获取幸运泡泡抽奖次数
  static const String getBubbleDrawCount = "/draw/getBubbleDrawCount";

  ///赛⻋路段速度排⾏
  static const String playRacingCarSpeedSortApi = "/game/racingSpeed";

  ///所有赛⻋开奖记录
  static const String playRacingRecord = "/game/racingRecordPage";

  ///当前⽤户赛⻋开奖记录
  static const String playRacingPersonalRecord = "/game/racingResultPage";

  ///赛⻋规则
  static const String playRacingRule = "/game/racingHelp";

  ///赛⻋⻋辆综合信息
  static const String playRacingCarDetail = "/game/racingDetail";

  ///幸运数字规则
  static const String playRollRule = "/game/luckyNumberOdds";

  ///幸运数字记录
  static const String playRollRecord = "/game/luckyNumberResultPage";

  ///购买幸运泡泡抽奖次数
  static const String buyBubbleCount = "/draw/buyBubbleDraw";

  ///幸运泡泡奖品
  static const String bubbleReward = "/draw/getBubbleConfig";

  ///幸运泡泡抽奖
  static const String bubbleAction = "/draw/bubbleDraw";

  ///幸运数字下注
  static const String playRollChipApi = "/game/luckyNumberBet";

  ///赛⻋下注
  static const String playRacingChipApi = "/game/racingBet";

  ///游戏⼊⼝开关
  static const String playEnterApi = "/game/enable";

  ///礼物卡背包
  static const String giftBackPackage = "/prop/getGiftCards";

  ///签到头像
  static const String loadSignAvatar = "/prop/getChatCardAndPortraitFrame";

  static const String getDailyConfigs = "/signin/getDailyConfigs";

  static const String signInDaily = "/signin/signInDaily/";

  static const String point = "/user/probe";

  static const String getAiHelp = "/robot/getAiHelp";

  static const String getDrawProduct = "/channelpay/getDrawProduct/";

  //判断谷歌账户是否绑定app账户
  static String checkBindGoogleAccount = "/user/checkBindGoogleAccount";

  //判断客户端缓存的登录数据
  static String checkCacheAccount = "/user/checkCacheAccount";

  //获取用户当前生效的复购奖励配置
  static const getActiveConfig = "/orderRebuyConfig/getActiveConfig";
}
