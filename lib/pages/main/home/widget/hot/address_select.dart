import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/main/home/widget/hot/select_area.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_loading.dart';

void showAddressSelect(Function(AreaData?) func, {String? path}) {
  List<AreaData> data = StorageService.to.getAreaList();
  //debugPrint("areaList =>> ${areaList}");
  if (data.isEmpty) {
    AnchorAPI.loadAreas().then((data) {
      StorageService.to.saveAreaList(data);
      showAreaDialog(data, path ?? "", func);
    }).catchError((err) {
      AppLoading.toast(err.message);
    });
  } else {
    showAreaDialog(data, path ?? "", func);
  }
}

///显示地区弹窗
void showAreaDialog(
    List<AreaData> data, String path, Function(AreaData?) func) {
  for (var value in data) {
    value.isSelect = (value.path == path);
  }
  Get.dialog(
      SelectArea(
          data: data,
          func: (item) {
            func.call(item);
          }),
      barrierColor: Colors.black45,
      routeSettings: const RouteSettings(name: AppPages.selectAreaDialog),
      barrierDismissible: false);
}
