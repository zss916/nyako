import 'package:nyako/objectbox.g.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/point/point_entity.dart';

class PointDB {
  PointDB._internal();

  static final PointDB _instance = PointDB._internal();

  static PointDB get instance => _instance;

  void add(PointEntity data) {
    StorageService.to.mPointBox.putAsync(data);
  }

  List<PointEntity> getAll(int now) {
    List<PointEntity> list = StorageService.to.mPointBox.getAll();
    if (list.isNotEmpty) {
      if (now - (list.last.probeTime ?? 0) < 2 * 60 * 1000) {
        return [];
      } else {
        return list;
      }
    } else {
      return [];
    }
  }

  void cleanAll(int now) {
    var query = StorageService.to.mPointBox
        .query(PointEntity_.probeTime.lessThan(now))
        .order(PointEntity_.probeTime)
        .build();
    List<int> ids = query.findIds();
    query.close();
    StorageService.to.mPointBox.removeManyAsync(ids);
  }
}
