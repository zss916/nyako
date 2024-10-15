import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/widget/app_click_widget.dart';

class BuildSwitch extends StatefulWidget {
  late bool isSwitch;
  Function(bool value) onChange;
  BuildSwitch({super.key, required this.isSwitch, required this.onChange});

  @override
  State<BuildSwitch> createState() => _BuildSwitchState();
}

class _BuildSwitchState extends State<BuildSwitch> {
  @override
  Widget build(BuildContext context) {
    return AppClickWidget(
      onTap: () {
        if (mounted) {
          setState(() {
            widget.isSwitch = !widget.isSwitch;
            widget.onChange(widget.isSwitch);
          });
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          widget.isSwitch
              ? Image.asset(
                  Assets.iconSwitchOpen,
                  width: 40,
                  height: 23,
                  matchTextDirection: true,
                )
              : Image.asset(
                  Assets.iconSwitchClose,
                  width: 40,
                  height: 23,
                  matchTextDirection: true,
                )
        ],
      ),
    );
  }
}
