import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialClassicHeader(
      height: 40,
      offset: 60,
      color: Color(0xFFFF3878),
    );
  }
}
