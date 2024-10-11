import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oliapro/common/language_key.dart';

class AppFormatUtil {
  static String getVerboseDateTimeRepresentation(DateTime dateTime,
      {bool timeOnly = false}) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(const Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return Tr.app_base_just_now.tr;
    }
    return DateFormat('yy.MM.dd HH:mm', const Locale("en").toLanguageTag())
        .format(dateTime);
  }

  static String currencyToSymbol(String? currency) {
    if (currency == null) {
      return "";
    }
    var format = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: currency);
    String symbol = format.currencySymbol;
    if (symbol.length >= 2) {
      return symbol;
    } else {
      return '$currency$symbol';
    }
  }

  /// 秒转换成时间（01:32）
  static String getTimeStrFromSecond(int second) {
    var seconds = second;
    var secondsPerHour = 3600;
    var secondsPerMinute = 60;

    var hours = seconds ~/ secondsPerHour;
    seconds = seconds.remainder(secondsPerHour);

    if (seconds < 0) seconds = -seconds;

    var minutes = seconds ~/ secondsPerMinute;
    seconds = seconds.remainder(secondsPerMinute);

    var minutesPadding = minutes < 10 ? "0" : "";

    var secondsPadding = seconds < 10 ? "0" : "";
    return hours > 0
        ? "$hours:"
        : ''
            "$minutesPadding$minutes:"
            "$secondsPadding$seconds";
  }

  //转化年龄工具类
  static int getAge(DateTime brt) {
    int age = 0;
    DateTime dateTime = DateTime.now();
    if (brt.isAfter(dateTime) || brt.millisecondsSinceEpoch == 0) {
      //出生日期晚于当前时间，无法计算
      return 18;
    }
    int yearNow = dateTime.year; //当前年份
    int monthNow = dateTime.month; //当前月份
    int dayOfMonthNow = dateTime.day; //当前日期

    int yearBirth = brt.year;
    int monthBirth = brt.month;
    int dayOfMonthBirth = brt.day;
    age = yearNow - yearBirth; //计算整岁数
    if (monthNow <= monthBirth) {
      if (monthNow == monthBirth) {
        if (dayOfMonthNow < dayOfMonthBirth) age--; //当前日期在生日之前，年龄减一
      } else {
        age--; //当前月份在生日之前，年龄减一
      }
    }
    return age > 18 ? age : 18;
  }
}
