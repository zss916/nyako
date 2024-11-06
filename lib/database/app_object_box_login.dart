import 'package:nyako/database/entity/app_login_entity.dart';
import 'package:nyako/objectbox.g.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
/// 有数据模型更新要执行下面语句 =>>
/// flutter pub run build_runner build
/// flutter pub run build_runner build --delete-conflicting-outputs
class ObjectBoxLogin {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<AppLoginEntity> loginBox;

  ObjectBoxLogin._create(this.store) {
    loginBox = Box<AppLoginEntity>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static ObjectBoxLogin create(Store store) {
    return ObjectBoxLogin._create(store);
  }

  List<AppLoginEntity>? queryList() {
    var queryBuilder = loginBox.query();
    var query = queryBuilder.build();
    List<AppLoginEntity>? list = query.find();
    query.close();
    return list;
  }

  AppLoginEntity? getLastLogin() {
    var queryBuilder = loginBox.query()
      ..order(AppLoginEntity_.loginTime, flags: Order.descending);
    var query = queryBuilder.build();
    AppLoginEntity? bean = query.findFirst();
    query.close();
    return bean;
  }

  Future cleanAll() async {
    loginBox.removeAll();
  }

  //更新
  void updateInfo({String? nickName, String? profile, String? diamondCount}) {
    var entity = getLastLogin();
    if (entity != null) {
      var queryBuilder =
          loginBox.query(AppLoginEntity_.userId.equals(entity.userId));
      var query = queryBuilder.build();
      //AppLoginEntity? oldEntity = query.findUnique();
      query.close();
      if (nickName != null) {
        entity.nickName = nickName;
      }
      if (profile != null) {
        entity.profileUrl = profile;
      }
      if (diamondCount != null) {
        entity.diamondCount = diamondCount;
      }
      loginBox.put(entity);
    }
  }

  //更新密码
  void updatePsd(String userId, String password) {
    var queryBuilder = loginBox.query(AppLoginEntity_.userId.equals(userId));
    var query = queryBuilder.build();
    AppLoginEntity? oldEntity = query.findUnique();
    query.close();
    if (oldEntity != null) {
      oldEntity.password = password;
      loginBox.put(oldEntity);
    }
  }

  AppLoginEntity? getAccount(String userId) {
    var queryBuilder = loginBox.query(AppLoginEntity_.userId.equals(userId));
    var query = queryBuilder.build();
    AppLoginEntity? oldEntity = query.findUnique();
    query.close();
    return oldEntity;
  }

  // 更新或者插入
  void putOrUpdate(AppLoginEntity entity) {
    var queryBuilder =
        loginBox.query(AppLoginEntity_.userId.equals(entity.userId));
    var query = queryBuilder.build();
    AppLoginEntity? oldEntity = query.findUnique();
    query.close();
    //更新id
    if (oldEntity != null) {
      entity.id = oldEntity.id;
    }
    entity.lastLogin = true;
    // 有则更新，无则插入
    loginBox.put(entity);
  }
}
