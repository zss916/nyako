import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oliapro/generated/assets.dart';

enum LineType {
  online(0, 'online'),

  busy(1, 'busy'),

  offline(2, 'offline'),

  other(-1, 'other');

  const LineType(this.number, this.value);

  final int number;

  final String value;

  static LineType getTypeByTitle(String title) =>
      LineType.values.firstWhere((activity) => activity.name == title);

  static LineType getType(int number) =>
      LineType.values.firstWhere((activity) => activity.number == number);

  static String getValue(int number) =>
      LineType.values.firstWhere((activity) => activity.number == number).value;
}

class Util {
  static var lastPopTime = DateTime.now();

  // 防重复提交
  static bool checkClick({int needTime = 3}) {
    if (DateTime.now().difference(lastPopTime) > Duration(seconds: needTime)) {
      lastPopTime = DateTime.now();
      return true;
    }
    return false;
  }
}

///时间戳to HH:mm:ss
String formatDuration(int time) {
  Duration duration = Duration(milliseconds: time);
  String hours = duration.inHours.toString().padLeft(2, '0');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

///时间格式化，支持自定义格式
String dateFormat(int dateTime, {String formatStr = 'yyyy.MM.dd HH:mm:ss'}) {
  return DateFormat(formatStr)
      .format(DateTime.fromMillisecondsSinceEpoch(dateTime));
}

mixin DragInterface {
  var startPosition = Offset(4, Get.bottomBarHeight + 10);
  var dragStartOffset = Offset.zero;
  var moveOffset = Offset(4, Get.bottomBarHeight + 10).obs;

  /// 手势拖动开始
  void onDragStart(Offset localOffsetFromOrigin) {
    dragStartOffset = localOffsetFromOrigin;
  }

  /// 手势拖动
  void onDragMoveUpdate(Offset localOffsetFromOrigin) {
    Offset changeOffset = Offset(dragStartOffset.dx - localOffsetFromOrigin.dx,
        localOffsetFromOrigin.dy - dragStartOffset.dy);
    moveOffset.value = Offset(
        startPosition.dx - changeOffset.dx, startPosition.dy - changeOffset.dy);
  }

  /// 手势停止边界检测
  void onDragEnd(Size widgetSize, Size edgeSize, EdgeInsetsDirectional edge) {
    dragStartOffset = Offset.zero;
    if (moveOffset.value.dx < edge.start) {
      moveOffset.value = Offset(edge.start, moveOffset.value.dy);
    } else if (moveOffset.value.dx >
        (edgeSize.width - edge.end - widgetSize.width)) {
      moveOffset.value = Offset(
          edgeSize.width - edge.end - widgetSize.width, moveOffset.value.dy);
    } else if (moveOffset.value.dx > edgeSize.width / 2) {
      moveOffset.value = Offset(
          edgeSize.width - edge.end - widgetSize.width, moveOffset.value.dy);
    } else {
      moveOffset.value = Offset(edge.start, moveOffset.value.dy);
    }
    if (moveOffset.value.dy < edge.bottom) {
      moveOffset.value = Offset(moveOffset.value.dx, edge.bottom);
    } else if (moveOffset.value.dy >
        (edgeSize.height - widgetSize.height - edge.top)) {
      moveOffset.value = Offset(
          moveOffset.value.dx, edgeSize.height - widgetSize.height - edge.top);
    }
    startPosition = moveOffset.value;
  }
}

mixin DragInterface2 {
  var startPosition = Offset(4, Get.bottomBarHeight + 70);
  var dragStartOffset = Offset.zero;
  var moveOffset = Offset(4, Get.bottomBarHeight + 70).obs;

  /// 手势拖动开始
  void onDragStart(Offset localOffsetFromOrigin) {
    dragStartOffset = localOffsetFromOrigin;
  }

  /// 手势拖动
  void onDragMoveUpdate(Offset localOffsetFromOrigin) {
    Offset changeOffset = Offset(dragStartOffset.dx - localOffsetFromOrigin.dx,
        localOffsetFromOrigin.dy - dragStartOffset.dy);
    moveOffset.value = Offset(
        startPosition.dx - changeOffset.dx, startPosition.dy - changeOffset.dy);
  }

  /// 手势停止边界检测
  void onDragEnd(Size widgetSize, Size edgeSize, EdgeInsetsDirectional edge) {
    dragStartOffset = Offset.zero;
    if (moveOffset.value.dx < edge.start) {
      moveOffset.value = Offset(edge.start, moveOffset.value.dy);
    } else if (moveOffset.value.dx >
        (edgeSize.width - edge.end - widgetSize.width)) {
      moveOffset.value = Offset(
          edgeSize.width - edge.end - widgetSize.width, moveOffset.value.dy);
    } else if (moveOffset.value.dx > edgeSize.width / 2) {
      moveOffset.value = Offset(
          edgeSize.width - edge.end - widgetSize.width, moveOffset.value.dy);
    } else {
      moveOffset.value = Offset(edge.start, moveOffset.value.dy);
    }
    if (moveOffset.value.dy < edge.bottom) {
      moveOffset.value = Offset(moveOffset.value.dx, edge.bottom);
    } else if (moveOffset.value.dy >
        (edgeSize.height - widgetSize.height - edge.top)) {
      moveOffset.value = Offset(
          moveOffset.value.dx, edgeSize.height - widgetSize.height - edge.top);
    }
    startPosition = moveOffset.value;
  }
}

/// url图片加载
Widget cachedImage(String url,
    {double? width,
    double? height,
    BoxFit? fit = BoxFit.cover,
    int? type = 0}) {
  /*Image holderImage = Image.asset(
    Assets.launcherAndLogo,
    width: width,
    height: height,
    fit: fit,
  );*/

  Widget holderImage = Container(
    color: Colors.white12,
  );

  if (type == 100) {
    holderImage = Image.asset(
      Assets.imgAnchorDefaultAvatar,
      width: width,
      height: height,
      fit: fit,
    );
  }

  if (url.isEmpty) {
    return holderImage;
  }

  return url.contains("images/default")
      ? Image.asset(
          Assets.imgAppLogo,
          fit: BoxFit.cover,
          width: width,
          height: height,
        )
      : CachedNetworkImage(
          height: height,
          width: width,
          /*progressIndicatorBuilder: (context, url, progress) {
            double p = (progress.progress ?? 0) * 100;
            return Center(
              child: Text(
                "${p}%",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }*/
          fit: BoxFit.cover,
          placeholder: (
            BuildContext context,
            String url,
          ) =>
              holderImage,
          errorWidget: (
            BuildContext context,
            String url,
            dynamic error,
          ) =>
              holderImage,
          imageUrl: url);
}

///
Widget cachedNetImage(String url,
    {double? width, double? height, BoxFit? fit = BoxFit.cover}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (
        BuildContext context,
        String url,
      ) =>
          Container(
            decoration: const BoxDecoration(
                color: Color(0x33000000),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            height: height,
            width: width,
          ),
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) =>
          Container(
            decoration: const BoxDecoration(
                color: Color(0x33FFE958),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            height: height,
            width: width,
          ),
      imageUrl: url);
}

///安全find
S? safeFind<S>() {
  if (Get.isRegistered<S>() == true) {
    final s = Get.find<S>();
    return s;
  }
  return null;
}

LocaleType get currentUerLanguageType {
  if (Get.locale?.languageCode == null) {
    return LocaleType.en;
  }

  if (Get.locale!.languageCode.matchAsPrefix("ar") != null) {
    return LocaleType.ar;
  } else if (Get.locale!.languageCode.matchAsPrefix("id") != null) {
    return LocaleType.id;
  } else if (Get.locale!.languageCode.matchAsPrefix("tr") != null) {
    return LocaleType.tr;
  } else if (Get.locale!.languageCode.matchAsPrefix("hi") != null) {
    return LocaleType.hi;
  } else if (Get.locale!.languageCode.matchAsPrefix("es") != null) {
    return LocaleType.es;
  } else if (Get.locale!.languageCode.matchAsPrefix("pt") != null) {
    return LocaleType.pt;
  } else if (Get.locale!.languageCode.matchAsPrefix("vi") != null) {
    return LocaleType.vi;
  } else if (Get.locale!.languageCode.matchAsPrefix("zh") != null) {
    return LocaleType.zh;
  }
  return LocaleType.en;
}

const Gradient foregroundBoxDecoration = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.black12,
    Colors.black26,
    Colors.black38,
    Colors.black45,
    Colors.black54,
  ],
);

const Gradient foregroundBoxDecoration2 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.black12,
    Colors.black12,
    Colors.black12,
    Colors.black26,
    Colors.black38,
    Colors.black45,
    Colors.black54,
  ],
);

const Gradient foregroundBoxDecoration3 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.black12,
    Colors.black12,
    Colors.black12,
    Colors.black26,
    Colors.black38,
    Colors.black45,
    Colors.black54,
    Colors.black54,
  ],
);
