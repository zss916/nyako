import 'package:nyako/http/api/index.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';

class AppCheckDND {
  static checkDND() async {
    int time = 24 * 60 * 60;
    int now = DateTime.now().millisecond;
    int dndTime = StorageService.to.getDND();
    if ((now - dndTime) > time) {
      await ProfileAPI.setDnd(isDoNotDisturb: false, showLoading: false);
      UserInfo.to.myDetail?.isDoNotDisturb = 0;
    }
  }
}
