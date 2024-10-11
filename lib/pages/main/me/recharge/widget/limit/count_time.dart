import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/services/app_time_service.dart';

class CountTime extends StatefulWidget {
  final int duration;

  const CountTime({super.key, required this.duration});

  @override
  State<CountTime> createState() => _CountTimeState();
}

class _CountTimeState extends State<CountTime> {
  @override
  void initState() {
    super.initState();
    if (AppTimeService.to.duration != (widget.duration ~/ 1000)) {
      AppTimeService.to.quickLeftTime.value = (widget.duration ~/ 1000);
      AppTimeService.to.duration = (widget.duration ~/ 1000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 20,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(4)),
              child: Text(
                second2HMS(AppTimeService.to.quickLeftTime.value).$1,
                maxLines: 1,
                style: const TextStyle(
                    color: Color(0xFFFF3A79),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 3),
              child: const Text(
                ":",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Container(
              height: 20,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(4)),
              child: Text(
                second2HMS(AppTimeService.to.quickLeftTime.value).$2,
                maxLines: 1,
                style: const TextStyle(
                    color: Color(0xFFFF3A79),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 3),
              child: const Text(
                ":",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Container(
              height: 20,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(4)),
              child: Text(
                second2HMS(AppTimeService.to.quickLeftTime.value).$3,
                maxLines: 1,
                style: const TextStyle(
                    color: Color(0xFFFF3A79),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            )
          ],
        ));
  }

  (String h, String m, String s) second2HMS(int sec) {
    String h = "00";
    String m = "00";
    String s = "00";
    if (sec > 0) {
      h = zeroFill(sec ~/ 3600);
      m = zeroFill((sec % 3600) ~/ 60);
      s = zeroFill(sec % 60);
    }
    return (h, m, s);
  }

  String zeroFill(int i) {
    return i >= 10 ? "$i" : "0$i";
  }
}
