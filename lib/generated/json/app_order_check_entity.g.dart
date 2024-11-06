import 'package:nyako/entities/app_order_check_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

OrderCheckEntity $OrderCheckEntityFromJson(Map<String, dynamic> json) {
  final OrderCheckEntity orderCheckEntity = OrderCheckEntity();
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    orderCheckEntity.orderNo = orderNo;
  }
  final int? orderStatus = jsonConvert.convert<int>(json['orderStatus']);
  if (orderStatus != null) {
    orderCheckEntity.orderStatus = orderStatus;
  }
  return orderCheckEntity;
}

Map<String, dynamic> $OrderCheckEntityToJson(OrderCheckEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  return data;
}

extension OrderCheckEntityExtension on OrderCheckEntity {
  OrderCheckEntity copyWith({
    String? orderNo,
    int? orderStatus,
  }) {
    return OrderCheckEntity()
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus;
  }
}
