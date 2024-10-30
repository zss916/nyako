import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LimitTime extends StatefulWidget {
  final int? duration;
  const LimitTime({super.key, required this.duration});

  @override
  State<LimitTime> createState() => _LimitTimeState();
}

class _LimitTimeState extends State<LimitTime> {
  int countdown = 600;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    countdown = (widget.duration ?? 600000) ~/ 1000;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          _timer?.cancel();
          Get.back();
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    return "${duration.inHours.remainder(60).toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDuration(Duration(seconds: countdown)),
      style: const TextStyle(
          color: Color(0xFFFF4444), fontSize: 13, fontWeight: FontWeight.bold),
    );
  }
}
