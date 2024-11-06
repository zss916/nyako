import 'package:flutter/material.dart';
import 'package:nyako/app/app.dart';
import 'package:nyako/utils/global.dart';

void main() async {
  await AppGlobal.init();
  runApp(const App());
}
