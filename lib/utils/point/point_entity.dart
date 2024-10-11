import 'package:objectbox/objectbox.dart';

@Entity()
class PointEntity {
  int id;
  int? probeType;
  int? probeId;
  int? probeTime;
  String? remark;

  PointEntity({
    this.id = 0,
    required this.probeType,
    required this.probeId,
    required this.probeTime,
    required this.remark,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['probeType'] = probeType;
    data['probeId'] = probeId;
    data['probeTime'] = probeTime;
    data['remark'] = remark;
    return data;
  }
}
