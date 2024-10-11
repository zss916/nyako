import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Arrow extends StatelessWidget {

  final Widget? child;

  Arrow({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(quarterTurns: Get.locale?.languageCode == "ar"?2:0,child: child ??  Icon(Icons.arrow_forward_rounded,size: 20,color:Colors.white.withOpacity(0.5) ,),);
  }

}
