import 'package:flutter/material.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialClassicHeader(
      height: 40,
      color: AppColors.colorFF2A48,
    );
  }
}
