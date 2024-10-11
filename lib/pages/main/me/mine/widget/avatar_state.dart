import 'package:oliapro/services/user_info.dart';

enum AvatarStatus {
  common,
  vip,
  sign,
}

class AvatarStatusHand {
  static int vipPropID = -999;

  static int type = AvatarStatus.common.index;

  ///只有穿戴使用
  static setAvatarType({int type = 0}) {
    type = type;
    UserInfo.to.setAvatarType(type);
  }

  static int getType() {
    int type = UserInfo.to.getAvatarType();
    if (type != 0) {
      ///缓存是VIP
      if (type == AvatarStatus.vip.index) {
        if (!UserInfo.to.isUserVip) {
          if (UserInfo.to.hasSignFrame) {
            type = AvatarStatus.sign.index;
            setAvatarType(type: type);
          } else {
            type = AvatarStatus.common.index;
            setAvatarType(type: type);
          }
        } else {
          type = type;
        }
      }

      ///缓存是签到
      if (type == AvatarStatus.sign.index) {
        if (UserInfo.to.hasSignFrame) {
          type = type;
        } else {
          if (UserInfo.to.isUserVip) {
            type = AvatarStatus.vip.index;
            setAvatarType(type: type);
          } else {
            type = AvatarStatus.common.index;
            setAvatarType(type: type);
          }
        }
      }
      return type;
    } else {
      if (UserInfo.to.isUserVip) {
        type = AvatarStatus.vip.index;
      } else if (UserInfo.to.hasSignFrame) {
        type = AvatarStatus.sign.index;
      } else {
        type = AvatarStatus.common.index;
      }
      return type;
    }
  }
}
