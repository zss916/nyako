import 'package:flutter/material.dart';

class Triangle extends StatelessWidget {
  const Triangle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
              color: Colors.transparent, width: 12, style: BorderStyle.solid),
          top: BorderSide(
              color: Colors.black38, width: 12, style: BorderStyle.solid),
          end: BorderSide(
              color: Colors.black38, width: 12, style: BorderStyle.solid),
          start: BorderSide(
              color: Colors.transparent, width: 12, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
