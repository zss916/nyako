import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';

class TopTitle extends StatelessWidget {
  final String title;

  const TopTitle(this.title, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: AlignmentDirectional.bottomCenter,
          padding: const EdgeInsets.only(top: 0, bottom: 3, left: 0, right: 0),
          child: Text(
            title,
            maxLines: 1,
            style: TextStyle(
                fontSize: 21,
                fontFamily: AppConstants.fontsBold,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ],
    );
  }
}
