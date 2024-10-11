import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class FollowBtn extends StatefulWidget {
  bool? isFollowed;
  FollowBtn({Key? key, this.isFollowed}) : super(key: key);

  @override
  _FollowBtnState createState() => _FollowBtnState();
}

class _FollowBtnState extends State<FollowBtn> {
  @override
  Widget build(BuildContext context) {
    return widget.isFollowed == true
        ? Image.asset(
            Assets.imgFollowed,
            width: 40,
            height: 30,
            matchTextDirection: true,
          )
        : Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF41BFFF),
              borderRadius: BorderRadius.circular(17),
            ),
            padding: const EdgeInsetsDirectional.only(
                start: 8, end: 8, top: 10, bottom: 10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 4),
                  child: Image.asset(
                    Assets.imgFollow,
                    width: 10,
                    height: 10,
                  ),
                ),
                Text(
                  Tr.app_details_follow.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                )
              ],
            ),
          );
  }
}
