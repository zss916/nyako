import 'package:nyako/database/entity/app_order_entity.dart';
import 'package:nyako/objectbox.g.dart';
import 'package:nyako/services/user_info.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
/// 有数据模型更新要执行下面语句 =>>
/// flutter pub run build_runner build
/// flutter pub run build_runner build --delete-conflicting-outputs
class ObjectBoxOrder {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<OrderEntity> orderBox;

  String get _getMyId => (UserInfo.to.userLogin?.userId) ?? "emptyId";

  ObjectBoxOrder._create(this.store) {
    orderBox = Box<OrderEntity>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static ObjectBoxOrder create(Store store) {
    // Future<Store> openStore() {...} is defined in the generated noramuztiobjectbox.g.dart
    return ObjectBoxOrder._create(store);
  }

  List<OrderEntity>? queryOrderList() {
    var queryBuilder = orderBox.query(OrderEntity_.userId.equals(_getMyId));
    var query = queryBuilder.build();
    List<OrderEntity>? list = query.find();
    query.close();
    return list;
  }

  OrderEntity? queryOrder(String orderId) {
    var queryBuilder = orderBox.query(OrderEntity_.orderNo.equals(orderId) &
        OrderEntity_.userId.equals(_getMyId));
    var query = queryBuilder.build();
    OrderEntity? order = query.findUnique();
    query.close();
    return order;
  }

  // 更新或者插入
  void putOrUpdateOrder(OrderEntity order) {
    var queryBuilder = orderBox.query(
        OrderEntity_.orderNo.equals(order.orderNo ?? '') &
            OrderEntity_.userId.equals(_getMyId));
    var query = queryBuilder.build();
    OrderEntity? orderOld = query.findUnique();
    query.close();
    if (orderOld != null) {
      order.id = orderOld.id;
    }
    // 有则更新，无则插入
    orderBox.put(order);
  }

  // google 的根据订单id更新支付时间
  void updateOrderPayTime(String orderId) {
    var queryBuilder = orderBox.query(OrderEntity_.orderNo.equals(orderId) &
        OrderEntity_.userId.equals(_getMyId));
    var query = queryBuilder.build();
    OrderEntity? orderOld = query.findUnique();
    query.close();
    if (orderOld != null) {
      orderOld.payTime = DateTime.now().millisecondsSinceEpoch.toString();
      orderBox.put(orderOld);
    }
  }

  // ios 查找最近的一单
  void updateOrderPayTimeIos(String productId) {
    var queryBuilder = orderBox.query(OrderEntity_.productId.equals(productId) &
        OrderEntity_.userId.equals(_getMyId))
      ..order(OrderEntity_.dateInsert);
    var query = queryBuilder.build();
    OrderEntity? orderOld = query.findFirst();
    query.close();
    if (orderOld != null) {
      orderOld.payTime = DateTime.now().millisecondsSinceEpoch.toString();
      orderBox.put(orderOld);
    }
  }

  void deleteOrderHadDone() {
    var queryBuilder = orderBox.query(OrderEntity_.orderStatus.greaterThan(1) |
        OrderEntity_.isUploadServer.equals(true));
    var query = queryBuilder.build();
    int aic = query.remove();
    query.close();
  }
//
// OrderEntity? queryAicCanShow() {
//   var queryBuilder = orderBox.query(OrderEntity_.playState.equals(1) &
//       OrderEntity_.localPath.notNull())
//     ..order(OrderEntity_.dateInsert);
//   var query = queryBuilder.build();
//   OrderEntity? order = query.findFirst();
//   query.close();
//   return order;
// }
}
