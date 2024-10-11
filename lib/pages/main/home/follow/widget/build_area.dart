import 'package:flutter/material.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildArea extends StatelessWidget {
  String path;
  String title;

  BuildArea(this.title, this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
      decoration: const BoxDecoration(
          color: Color(0x1AFF890E),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: cachedImage(path, width: 15, height: 15),
          ),
          Container(
            margin: const EdgeInsets.only(left: 2),
            child: Text(
              title,
              style: const TextStyle(color: Color(0xFFFF890E), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
