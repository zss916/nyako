enum CodeStatus {
  fail(-1, des: '失败'),
  ok(0, des: '成功'),
  tokenLose(2, des: 'token无效'),
  userLose(3, des: '用户不存在'),
  productLose(4, des: '商品不存在'),
  parameterError(5, des: '参数错误'),
  loginFail(6, des: '登录失败'),
  recipientBusy(7, des: '对方忙线'),
  balanceLack(8, des: '余额不足'),
  createRoomFail(50, des: '创建房间失败'),
  roomIdLose(51, des: '房间Id不存在'),
  repeatToMicro(52, des: '重复上麦'),
  toMicroFail(53, des: '上麦请求失败'),
  subscribeToFail(60, des: '订阅失败'),
  registerFail(62, des: '注册失败'),
  repeatOperate(63, des: '重复操作'),
  repeatSignIn(71, des: '重复签到');

  const CodeStatus(this.status, {required this.des});

  final int status;

  final String des;

  static CodeStatus getStatusByName(String name) =>
      CodeStatus.values.firstWhere((s) => s.name == name);

  static CodeStatus getStatus(int status) =>
      CodeStatus.values.firstWhere((s) => s.status == status);

  static String getDes(int status) =>
      CodeStatus.values.firstWhere((s) => s.status == status).des;

  static String getName(int status) =>
      CodeStatus.values.firstWhere((s) => s.status == status).name;
}
