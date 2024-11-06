import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/services/user_info.dart';

class BuildMsgCardDownTime extends StatefulWidget {
  const BuildMsgCardDownTime({super.key});

  @override
  State<BuildMsgCardDownTime> createState() => _BuildGiftState();
}

class _BuildGiftState extends State<BuildMsgCardDownTime> {
  Timer? _timer;
  int countdown = 0;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      countdown <= 0 ? "--" : second2HMS(countdown ~/ 1000),
      maxLines: 1,
      maxFontSize: 16,
      minFontSize: 10,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: const Color(0xFF9341FF),
          fontSize: 16,
          fontFamily: AppConstants.fontsRegular,
          fontWeight: FontWeight.normal),
    );
  }

  String second2HMS(int sec) {
    String hms = "00:00:00";
    if (sec > 0) {
      int h = sec ~/ 3600;
      int m = (sec % 3600) ~/ 60;
      int s = sec % 60;
      hms = "${zeroFill(h)}:${zeroFill(m)}:${zeroFill(s)}";
    }
    return hms;
  }

  String zeroFill(int i) {
    return i >= 10 ? "$i" : "0$i";
  }

  @override
  void initState() {
    super.initState();
    if (UserInfo.to.myMsgCard != null) {
      countdown = UserInfo.to.myMsgCard?.getRemainTimes() ?? 100;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            countdown -= 1000;
            if (countdown <= 0) {
              _timer?.cancel();
              _timer = null;
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
