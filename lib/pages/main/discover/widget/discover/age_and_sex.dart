import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';

class AgeAndSex extends StatelessWidget {
  final String age;

  const AgeAndSex({super.key, required this.age});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsetsDirectional.only(top: 2),
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 6, right: 6),
      decoration: const BoxDecoration(
          color: Color(0xFFFF3978),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            //color: Colors.blue,
            margin: const EdgeInsetsDirectional.only(end: 2, top: 1),
            child: Image.asset(
              Assets.iconSmallWoman,
              matchTextDirection: true,
              width: 11,
              height: 15,
            ),
          ),
          Container(
            // color: Colors.deepPurple,
            child: Text(
              age,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  //fontFamily: AppConstants.fontsRegular,
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
