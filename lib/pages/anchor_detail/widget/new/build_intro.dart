import 'package:flutter/material.dart';

class BuildIntro extends StatelessWidget {
  final String intro;
  final double? margin;
  const BuildIntro({super.key, required this.intro, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      //color: Colors.blue,
      padding: const EdgeInsetsDirectional.only(top: 0, bottom: 10),
      margin:
          EdgeInsetsDirectional.only(start: margin ?? 20, end: margin ?? 20),
      child: Text(
        intro,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        softWrap: true,
        style: const TextStyle(
            color: Colors.white70, fontWeight: FontWeight.normal, fontSize: 14),
      ),
    );
  }
}
