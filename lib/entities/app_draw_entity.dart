import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/utils/app_some_extension.dart';

import '../common/language_key.dart';
import '../generated/json/app_draw_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class DrawEntity {
  int? code;
  String? message;
  List<DrawData>? data;
  dynamic page;

  DrawEntity();

  factory DrawEntity.fromJson(Map<String, dynamic> json) =>
      $DrawEntityFromJson(json);

  Map<String, dynamic> toJson() => $DrawEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DrawData {
  int? configId;
  String? name;
  String? icon;
  int? areaCode;
  int? probability;
  int? drawMode;
  int? drawType;
  int? value;
  //本地
  ui.Image? image;
  Color? color;
  String? content;
  DrawData();

  factory DrawData.fromJson(Map<String, dynamic> json) =>
      $DrawDataFromJson(json);

  Map<String, dynamic> toJson() => $DrawDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  String getResult() {
    switch (drawType) {
      case 0:
        return Tr.app_draw0.tr;
      case 1:
        return Tr.app_luck_diamond.trArgs(["$value"]);
      case 2:
        return Get.locale?.languageCode == "vi"
            ? "VIP ${value} \nngày"
            : Tr.app_draw2.trArgs(["$value"]);
      case 3:
        return Tr.app_prop_add_content2.trArgs(["$value%", "$value%"]);
      case 4:
        return "$name x$value";
      case 5:
        return Tr.appSignMsgCard.trArgs(["$value"]);
      default:
        return Tr.app_level_congratulations.tr;
    }
  }

  String getResult2() {
    switch (drawType) {
      case 0:
        return "";
      case 1:
        return Tr.app_luck_diamond.trArgs(["$value"]);
      case 2:
        return Get.locale?.languageCode == "vi"
            ? "VIP ${value} \nngày"
            : Tr.app_draw2.trArgs(["$value"]);
      case 3:
        return Tr.app_prop_add_title.trArgs(["$value"]);
      case 4:
        return "$name";
      case 5:
        return Tr.appSignMsgCard.trArgs(["$value"]);
      default:
        return "";
    }
  }

  String getContent() {
    switch (drawType) {
      case 0:
        return Tr.app_draw0.tr;
      case 1:
        return "$value";
      case 2:
        return Tr.app_draw2.trArgs(["$value"]);
      case 3:
        return Get.isTr ? "%$value" : "$value%";
      case 5:
        return "$name";
      default:
        return "$value";
    }
  }

  String getContent2() {
    switch (drawType) {
      case 0:
        return "";
      case 1:
        return "x$value";
      case 2:
        return "+$value";
      case 3:
        return Get.isTr ? "+%$value" : "+$value%";
      case 5:
        return "$name";
      default:
        return "$value";
    }
  }

  Future<ui.Image> handImg({bool isDefault = true}) async {
    String? img = ((icon ?? '').startsWith("https://") ? icon : null);
    String? path = isDefault ? null : img;
    switch (drawType) {
      case 0:
        return await loadImage(path ?? Assets.lotteryLotteryEmpty, path != null)
            .then((value) => image = value);
      case 1:
        return await loadImage(
                path ?? Assets.lotteryLotteryDiamond, path != null)
            .then((value) => image = value);
      case 2:
        return await loadImage(path ?? Assets.lotteryLotteryKing, path != null)
            .then((value) => image = value);
      case 3:
        return await loadImage(
                path ?? Assets.lotteryLotteryAddCard, path != null)
            .then((value) => image = value);
      case 5:
        return await loadImage(
                path ?? Assets.lotteryLotteryCallCard, path != null)
            .then((value) => image = value);
      default:
        return await loadImage(img ?? Assets.imgAppLogo, img != null)
            .then((value) => image = value);
    }
  }

  // 获取图片 本地为false 网络为true
  Future<ui.Image> loadImage(var path, bool isUrl) async {
    ImageStream stream;
    if (isUrl) {
      stream = NetworkImage(path).resolve(ImageConfiguration.empty);
    } else {
      stream = AssetImage(path, bundle: rootBundle)
          .resolve(ImageConfiguration.empty);
    }

    Completer<ui.Image> completer = Completer<ui.Image>();
    void listener(ImageInfo frame, bool synchronousCall) {
      final ui.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(ImageStreamListener(listener));
    }

    stream.addListener(ImageStreamListener(listener));
    return completer.future;
  }
}
