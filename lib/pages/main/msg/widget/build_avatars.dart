import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/msg/widget/base_msg_portrait.dart';

class BuildAvatars extends StatelessWidget {
  final bool isSystem;
  final String portrait;
  const BuildAvatars(this.isSystem, this.portrait, {super.key});

  @override
  Widget build(BuildContext context) {
    return isSystem
        ? Image.asset(
            Assets.iconSystem,
            width: 50,
            height: 50,
            matchTextDirection: true,
            fit: BoxFit.fill,
          )
        : BaseMsgPortrait(portrait, -1);
  }
}
