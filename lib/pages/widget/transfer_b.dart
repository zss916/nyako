import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transferb extends StatelessWidget {

  final Widget? child;
  final int? turn;


  Transferb({Key? key, this.child,this.turn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(quarterTurns: turn??0,child: child);
  }

}
