import 'package:flutter/material.dart';
import 'package:oliapro/app/app.dart';
import 'package:oliapro/utils/global.dart';

void main() async {
  await AppGlobal.init();
  runApp(const App());
}
