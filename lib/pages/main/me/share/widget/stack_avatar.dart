import 'package:flutter/material.dart';
import 'package:nyako/utils/app_extends.dart';

class StackAvatarWidget extends StatefulWidget {
  late List<String> avatars = [];

  StackAvatarWidget(this.avatars, {super.key});

  @override
  State<StackAvatarWidget> createState() => _StackAvatarWidgetState();
}

class _StackAvatarWidgetState extends State<StackAvatarWidget> {
  final double sizeW = 38.0;
  final double offsetW = 11.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int len = widget.avatars.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          width: sizeW * len - 10 * (len - 1),
          height: 40,
          child: Stack(
            children: _getStackItems(widget.avatars.length > 3
                ? widget.avatars.sublist(0, 3)
                : widget.avatars),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        const Text(
          "...",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    );
  }

  List<Widget> _getStackItems(List<String> avatars) {
    List<Widget> _list = [];
    for (var i = 0; i < avatars.length; i++) {
      double off = (sizeW - offsetW) * i;
      _list.add(Positioned(
        left: off,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: cachedImage(
            avatars[i],
            width: sizeW,
            height: sizeW,
          ),
        ),
      ));
    }
    return _list;
  }
}
