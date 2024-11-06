import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/pages/main/me/mine/index.dart';
import 'package:nyako/pages/main/me/mine/widget/build_content_list.dart';
import 'package:nyako/pages/main/me/mine/widget/build_top_info.dart';

class MeBody extends StatelessWidget {
  final MeLogic logic;

  const MeBody(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: Colors.red,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              GetBuilder<MeLogic>(
                  init: MeLogic(),
                  builder: (logic) {
                    return BuildTopInfo(logic);
                  }),
              BuildContentList(logic),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        onRefresh: () => refresh(logic));
  }

  Future<void> refresh(MeLogic logic) async {
    logic.refreshMe();
    await Future.delayed(const Duration(seconds: 2));
  }
}
