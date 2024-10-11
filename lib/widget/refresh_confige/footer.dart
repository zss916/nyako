import 'package:flutter/material.dart';
import 'package:oliapro/widget/app_ball_beat.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: (context, status) {
      return status == LoadStatus.loading
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsetsDirectional.only(top: 20, bottom: 10),
              child: const AppBallBeatIndicator(),
            )
          : const SizedBox.shrink();
    });
  }
}
