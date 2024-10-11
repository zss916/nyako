import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transfer extends StatelessWidget {

  final Widget? child;
  final int? turn;


  Transfer({Key? key, this.child,this.turn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(quarterTurns: Get.locale?.languageCode == "ar"?(turn??2):0,child: child);
  }

}
