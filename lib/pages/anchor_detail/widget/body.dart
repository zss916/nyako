import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/new/anchor_body.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';

class AnchorDetailsBody extends StatelessWidget {
  const AnchorDetailsBody({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnchorDetailLogic>(
        init: AnchorDetailLogic(),
        initState: (_) {
          BgmControl.anchorDetailsBgmClose();
        },
        dispose: (_) {
          BgmControl.anchorDetailBgmStart();
        },
        builder: (logic) => AnchorBody(logic: logic));
  }
}
