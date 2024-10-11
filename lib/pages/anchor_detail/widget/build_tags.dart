import 'package:flutter/material.dart';

class BuildTags extends StatelessWidget {
  final List<String> tags;

  const BuildTags(this.tags, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsetsDirectional.only(
          bottom: tags.isEmpty ? 0 : 10, start: 15, end: 15),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: (tags)
            .map(
              (i) => buildTag(i, tags),
            )
            .toList(),
      ),
    );
  }

  Widget buildTag(String tag, List<String> tags) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: getColor(tags.indexOf(tag)).withOpacity(0.5),
          borderRadius: BorderRadiusDirectional.circular(18)),
      child: Text(
        tag,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Color getColor(int i) {
    Color color = const Color(0xFFFD3969);
    switch (i % 5) {
      case 0:
        color = const Color(0xFFFD3969);
        break;
      case 1:
        color = const Color(0xFF607CFB);
        break;
      case 2:
        color = const Color(0xFFFF73E7);
        break;
      case 3:
        color = const Color(0xFF85F181);
        break;
      case 4:
        color = const Color(0xFFFF7B42);
        break;
    }
    return color;
  }
}
