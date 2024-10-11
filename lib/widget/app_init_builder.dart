import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppInitBuilder extends StatelessWidget {
  final Widget? child;

  const AppInitBuilder(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyLoading.init()(context, BotToastInit()(context, child)),
    );
  }
}
