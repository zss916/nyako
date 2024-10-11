import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:oliapro/utils/app_extends.dart';

void showEditBirth(int showBirthday, Function(int) fun) {
  DateTime? birth;
  if (showBirthday != 0) {
    birth = DateTime.fromMillisecondsSinceEpoch(showBirthday);
  }
  DateTime nowTime = DateTime.now();
  DatePicker.showDatePicker(Get.context!,
      showTitleActions: true,
      minTime: DateTime(nowTime.year - 60, nowTime.month, nowTime.day),
      maxTime: DateTime(nowTime.year - 18, nowTime.month, nowTime.day),
      currentTime: birth ?? nowTime,
      locale: currentUerLanguageType, onConfirm: (date) {
    fun.call(date.millisecondsSinceEpoch);
  });
}
