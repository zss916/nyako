import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/database/app_object_box_login.dart';
import 'package:nyako/database/app_object_box_order.dart';
import 'package:nyako/entities/app_charge_quick_entity.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/point/point_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_object_box_call.dart';
import '../database/app_object_box_msg.dart';
import '../objectbox.g.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  late final SharedPreferences prefs;
  late final EventBus eventBus;

  List<String>? _momentReportList;
  List<String>? _myBlackList;
  List<String>? _mediaReportList;

  static const keyHadSetGender = "keyHadSetGender";
  static const keyAreaCode = "keyAreaCode";
  static const appTestStyle = "appTestStyle";
  static const appMatchPlayTip = "match_play_tip";
  static const openCarGame = "openCarGame";
  static const dnd = "dnd";
  static const areaList = "areaList";

  static const productList = "productList";

  late final ObjectBoxMsg objectBoxMsg;
  late final ObjectBoxCall objectBoxCall;
  late final ObjectBoxOrder objectBoxOrder;
  late final ObjectBoxLogin objectBoxLogin;
  late final Box<PointEntity> mPointBox;

  Future<StorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    eventBus = EventBus();
    final store = await openStore();
    objectBoxMsg = ObjectBoxMsg.create(store);
    objectBoxCall = ObjectBoxCall.create(store);
    objectBoxOrder = ObjectBoxOrder.create(store);
    objectBoxLogin = ObjectBoxLogin.create(store);
    mPointBox = Box<PointEntity>(store);
    return this;
  }

  //test mode 0线上，1预发布，2测试
  void saveTestStyle(int mode) {
    prefs.setInt(appTestStyle, mode);
  }

  int get getTestStyle {
    int? show = prefs.getInt(appTestStyle);
    return show ?? (AppConstants.isTestMode ? 0 : 0);
  }

  void saveProductList(List<PayQuickCommodite> data) {
    List<String> list = data.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList(
        productList + (UserInfo.to.userLogin?.userId ?? ""), list);
  }

  List<PayQuickCommodite> getProductList() {
    List<String> list = prefs.getStringList(
            productList + (UserInfo.to.userLogin?.userId ?? "")) ??
        <String>[];
    List<PayQuickCommodite> products = list
        .map((e) => PayQuickCommodite.fromJson(const JsonDecoder().convert(e)))
        .toList();
    return products;
  }

  void saveAreaList(List<AreaData> data) {
    List<String> list = data.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList(areaList + (UserInfo.to.userLogin?.userId ?? ""), list);
  }

  List<AreaData> getAreaList() {
    List<String> list =
        prefs.getStringList(areaList + (UserInfo.to.userLogin?.userId ?? "")) ??
            <String>[];
    List<AreaData> areaData = list
        .map((e) => AreaData.fromJson(const JsonDecoder().convert(e)))
        .toList();
    return areaData;
  }

  int getAreaCode() {
    return prefs.getInt(keyAreaCode + (UserInfo.to.userLogin?.userId ?? "")) ??
        -1;
  }

  void saveAreaCode(int code) {
    prefs.setInt(keyAreaCode + (UserInfo.to.userLogin?.userId ?? ""), code);
  }

  bool getHadSetGender() {
    return prefs
            .getBool(keyHadSetGender + (UserInfo.to.userLogin?.userId ?? "")) ??
        false;
  }

  void saveHadSetGender() {
    prefs.setBool(
        keyHadSetGender + (UserInfo.to.userLogin?.userId ?? ""), true);
  }

  void saveMatchPlay() {
    prefs.setBool(
        appMatchPlayTip + (UserInfo.to.userLogin?.userId ?? ""), true);
  }

  bool getMatchPlay() {
    return prefs
            .getBool(appMatchPlayTip + (UserInfo.to.userLogin?.userId ?? "")) ??
        false;
  }

  bool checkBlackList(String? herId) {
    var blackListKey = '${UserInfo.to.myDetail?.userId}-blackListKey';
    _myBlackList ??= prefs.getStringList(blackListKey) ?? [];
    if (herId == null || herId.isEmpty) return false;
    return _myBlackList!.contains(herId);
  }

  bool updateBlackList(String? herId, bool add) {
    var blackListKey = '${UserInfo.to.myDetail?.userId}-blackListKey';
    _myBlackList ??= prefs.getStringList(blackListKey) ?? [];
    if (herId == null || herId.isEmpty) return false;
    if (!add) {
      _myBlackList!.remove(herId);
      prefs.setStringList(blackListKey, _myBlackList!);
      return false;
    } else {
      _myBlackList!.add(herId);
      prefs.setStringList(blackListKey, _myBlackList!);
      return true;
    }
  }

  // 检查动态是否被拉黑
  bool checkMomentReportList(String? rId) {
    var momentReportListKey =
        '${UserInfo.to.myDetail?.userId}-momentReportListKey';
    _momentReportList ??= prefs.getStringList(momentReportListKey) ?? [];
    if (rId == null || rId.isEmpty) return false;
    return _momentReportList!.contains(rId);
  }

  // 拉黑动态
  bool updateMomentReportList(String? rId, {bool add = true}) {
    var momentReportListKey =
        '${UserInfo.to.myDetail?.userId}-momentReportListKey';
    _momentReportList ??= prefs.getStringList(momentReportListKey) ?? [];
    if (rId == null || rId.isEmpty) return false;
    if (!add) {
      _momentReportList!.remove(rId);
      prefs.setStringList(momentReportListKey, _momentReportList!);
      return false;
    } else {
      _momentReportList!.add(rId);
      prefs.setStringList(momentReportListKey, _momentReportList!);
      return true;
    }
  }

  // 检查主播媒体资源是否被拉黑
  bool checkMediaReportList(String? rId) {
    var mediaReportListKey =
        '${UserInfo.to.myDetail?.userId}-mediaReportListKey';
    _mediaReportList ??= prefs.getStringList(mediaReportListKey) ?? [];
    if (rId == null || rId.isEmpty) return false;
    return _mediaReportList!.contains(rId);
  }

  // 拉黑主播媒体资源
  bool updateMediaReportList(String? rId, {bool add = true}) {
    var mediaReportListKey =
        '${UserInfo.to.myDetail?.userId}-mediaReportListKey';
    _mediaReportList ??= prefs.getStringList(mediaReportListKey) ?? [];
    if (rId == null || rId.isEmpty) return false;
    if (!add) {
      _mediaReportList!.remove(rId);
      prefs.setStringList(mediaReportListKey, _mediaReportList!);
      return false;
    } else {
      _mediaReportList!.add(rId);
      prefs.setStringList(mediaReportListKey, _mediaReportList!);
      return true;
    }
  }

  void saveOpenCarGame() {
    prefs.setBool(openCarGame + (UserInfo.to.userLogin?.userId ?? ""), true);
  }

  bool getOpenCarGame() {
    return prefs.getBool(openCarGame + (UserInfo.to.userLogin?.userId ?? "")) ??
        false;
  }

  int getDND() {
    return prefs.getInt(dnd + (UserInfo.to.userLogin?.userId ?? "")) ?? 0;
  }

  void setDND(int time) {
    prefs.setInt(dnd + (UserInfo.to.userLogin?.userId ?? ""), time);
  }

  /// 是否显示签到弹窗
  bool canShowSign() {
    bool show = false;
    final showTime = prefs.getInt(
      "sign_show_time_key_${UserInfo.to.myDetail?.userId}",
    );
    if (showTime == null) {
      show = true;
      prefs.setInt("sign_show_time_key_${UserInfo.to.myDetail?.userId}",
          DateTime.now().millisecondsSinceEpoch);
    } else {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final last = DateFormat('yyyy-MM-dd')
          .format(DateTime.fromMillisecondsSinceEpoch(showTime));
      if (today != last) {
        show = true;
      }
    }
    debugPrint("sign show $show");
    return show;
  }
}
