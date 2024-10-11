import '../generated/json/base/json_field.dart';
import '../generated/json/app_order_check_entity.g.dart';

@JsonSerializable()
class OrderCheckEntity {
  OrderCheckEntity();

  factory OrderCheckEntity.fromJson(Map<String, dynamic> json) =>
      $OrderCheckEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrderCheckEntityToJson(this);

  String? orderNo;
  int? orderStatus;
}
