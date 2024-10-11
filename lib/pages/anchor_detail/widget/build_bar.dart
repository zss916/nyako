import 'package:flutter/material.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/back.dart';
import 'package:oliapro/pages/anchor_detail/widget/backgrand.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_avatar.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_follow.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_more.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_report.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/widget/semantics/label.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

class BuildBar extends StatelessWidget {
  final AnchorDetailLogic logic;

  final bool show;

  final double? d;

  const BuildBar(this.logic, this.show, {super.key, this.d});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverAppBar(
        backgroundColor: /*show ? const Color(0xFF1E1226) :*/
            Colors.transparent,
        pinned: true,
        leading: Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(start: 11),
              child: const Back().onLabel(label: SemanticsLabel.back),
            )
          ],
        ),
        actions: [
          if (show)
            UnconstrainedBox(
              child: BuildAvatar(logic),
            ),
          const Spacer(),
          if (show)
            Container(
              margin: const EdgeInsetsDirectional.only(end: 12),
              child: UnconstrainedBox(
                child: BuildFollow(logic),
              ),
            ),
          Container(
            alignment: AlignmentDirectional.center,
            child: BuildReport(
              logic.state.anchorId.toString(),
              type: ReportEnum.anchorDetail.index.toString(),
            ),
          ).onLabel(label: SemanticsLabel.report),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: BuildMore(logic).onLabel(label: SemanticsLabel.shield),
          ),
        ],
        elevation: 0,
        expandedHeight: 80 + 75 + 10 + 20 + (d ?? 0),
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          centerTitle: true,
          background: Backgarnd(logic.state.host, logic),
        ),
      ),
    );
  }
}
