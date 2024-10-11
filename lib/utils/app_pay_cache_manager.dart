import 'package:oliapro/database/entity/app_order_entity.dart';
import 'package:oliapro/entities/app_order_check_entity.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_pay_event_track.dart';

class AppPayCacheManager {
  // 检查缓存的订单，支付成功的上报后台和三方平台
  static checkOrderList() async {
    List<OrderEntity>? list = StorageService.to.objectBoxOrder.queryOrderList();
    if (list == null || list.isEmpty) {
      return;
    }
    var orderIds = <String>[];
    var orderMap = <String, OrderEntity>{};
    for (var element in list) {
      //订单支付状态未知 或者 待支付的订单 调用接口获取最新状态
      if (element.orderStatus == null || element.orderStatus == 0) {
        orderIds.add(element.orderNo ?? '');
        orderMap[element.orderNo ?? ''] = element;
      } else if (element.orderStatus == 3) {
        //支付失败的订单
      } else if (element.orderStatus == 1) {
        //支付成功的订单 未上传至服务器
        if (element.isUploadServer != true) {
          submitToServer(element);
        }
      }
    }
    if (orderMap.isEmpty) return;
    Http.instance.post<List<OrderCheckEntity>>(NetPath.getOrderStatusApi,
        data: {'orderNos': orderIds}).then((value) {
      for (var orderCheck in value) {
        var ord = orderMap[orderCheck.orderNo];
        if (ord != null) {
          ord.orderStatus = orderCheck.orderStatus;
          StorageService.to.objectBoxOrder.orderBox.put(ord);
          if (ord.orderStatus == 1 && ord.isUploadServer != true) {
            submitToServer(ord);
          }
        }
      }
    });
  }

  static submitToServer(OrderEntity orderEntity) {
    Http.instance
        .post<void>(NetPath.uploadLogApi, data: orderEntity.toJson())
        .then((value) {
      orderEntity.isUploadServer = true;
      StorageService.to.objectBoxOrder.orderBox.put(orderEntity);
      AppPayEventTrack.instance.trackPay(orderEntity);
    });
  }

  static clearValidOrder() async {
    StorageService.to.objectBoxOrder.deleteOrderHadDone();
  }
}
