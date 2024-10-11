import 'package:oliapro/utils/point/point_db.dart';
import 'package:oliapro/utils/point/point_entity.dart';
import 'package:oliapro/utils/point/point_type.dart';

class PointUtils {
  PointUtils._internal();

  static final PointUtils _instance = PointUtils._internal();

  static PointUtils get instance => _instance;

  static int pointCode = 1004;

  ///vip 续费弹窗埋点
  Future<void> toRenewPointA() async {
    PointEntity data = PointEntity(
      probeType: pointCode,
      probeId: PointType.vipRenewDialog.number,
      probeTime: DateTime.now().millisecondsSinceEpoch,
      remark: PointType.vipRenewDialog.value,
    );
    PointDB.instance.add(data);
  }

  ///会员中心续费埋点
  Future<void> toRenewPointB() async {
    PointEntity data = PointEntity(
      probeType: pointCode,
      probeId: PointType.vipCenterPage.number,
      probeTime: DateTime.now().millisecondsSinceEpoch,
      remark: PointType.vipCenterPage.value,
    );
    PointDB.instance.add(data);
  }

  ///vip 充值弹窗
  Future<void> toRenewPointC({required String explain}) async {
    PointEntity data = PointEntity(
      probeType: pointCode,
      probeId: PointType.vipRechargeDialog.number,
      probeTime: DateTime.now().millisecondsSinceEpoch,
      remark: "${PointType.vipRechargeDialog.value}-$explain",
    );
    PointDB.instance.add(data);
  }
}
