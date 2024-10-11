import 'package:flutter/material.dart';
import 'package:oliapro/entities/app_moment_entity.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/widget/line_state.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildItemAvatar extends StatelessWidget {
  final AnchorDetailLogic logic;
  final MomentDetail item;

  const BuildItemAvatar(this.logic, this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsetsDirectional.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 2, color: const Color(0xFFEF45A3))),
              child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(50),
                child: cachedImage(item.portrait ?? ""),
              )),
          SizedBox(
            height: 12,
            width: 12,
            child: LineState(item.lineState()),
          ),
        ],
      ),
    );
  }
}
