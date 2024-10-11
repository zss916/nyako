import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///ios 中light 黑色，dark 白色
SystemUiOverlayStyle darkBarStyle = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarBrightness: Brightness.dark, // 设置状态栏文字颜色为白色
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
);

SystemUiOverlayStyle lightBarStyle = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light, // 设置状态栏图标为白色
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarBrightness: Brightness.light, // 设置状态栏文字颜色为黑色
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
);
