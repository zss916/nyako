enum PointType {
  ///1004
  vipRenewDialog(100, 'VIP续费弹窗'),

  vipCenterPage(101, '会员中心续费'),

  vipRechargeDialog(103, 'vip 充值dialog'),

  other(104, 'other');

  final int number;

  final String value;

  const PointType(this.number, this.value);
}
