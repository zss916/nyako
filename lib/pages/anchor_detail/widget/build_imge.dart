import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_vip_image.dart';
import 'package:oliapro/pages/widget/app_preview.dart';
import 'package:oliapro/pages/widget/base_top_empty.dart';

class BuildImage extends StatelessWidget {
  final AnchorDetailLogic logic;
  final List<HostMedia> data;

  const BuildImage(this.logic, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              BaseTopEmpty(
                h: 30,
              ),
            ],
          )
        : Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              buildList(data, context),
            ],
          );
  }

  Widget buildList(List<HostMedia> data, BuildContext context) {
    // debugPrint("buildList ===>> ${data.length}");
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 119 / 169,
        ),
        itemCount: data.length,
        padding: const EdgeInsets.only(top: 0, bottom: 130, left: 0, right: 0),
        itemBuilder: (context, index) {
          //debugPrint("_albumItem path ==>>> $index, ${data[index].type??-1} ,${data[index].vipVisible},${data[index].path } ");
          return GestureDetector(
            onTap: () {
              if (logic.state.userVip) {
                showAnchorDetailPreview(data, context,
                    initIndex: index,
                    uid: logic.state.host.getUid,
                    data: logic.state.host);
              } else {
                if (data[index].vipVisible == 1) {
                  sheetToVip(
                      path: ChargePath.recharge_vip_dialog_anchor_details,
                      index: 4);
                } else {
                  List<HostMedia> arr =
                      data.where((element) => element.vipVisible == 0).toList();
                  int i = arr
                      .indexWhere((element) => element.mid == data[index].mid);
                  // debugPrint("aaa===>>> $i,${arr[i].path},${arr[i].isSelected}");
                  showAnchorDetailPreview(arr, context,
                      initIndex: i,
                      uid: logic.state.host.getUid,
                      data: logic.state.host);
                }
              }
            },
            child: _albumItem(data[index].showPath,
                isVip: (data[index].vipVisible == 1),
                isPhoto: data[index].type == 0,
                mid: data[index].mid ?? 0),
          );
        });
  }

  Widget _albumItem(String path,
      {bool isVip = true, bool isPhoto = false, int? mid}) {
    // debugPrint("_albumItem path ==>>> $isPhoto,====>> $path");
    //cachedImage(path,fit: BoxFit.cover,type: 5,width: double.maxFinite,height: double.maxFinite,)
    //widget.bean.heroId
    return !AppConstants.isFakeMode
        ? Hero(
            tag: "$mid",
            createRectTween: (begin, end) {
              return CircularRectTween(begin: begin!, end: end!);
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                if (isVip && (!logic.state.userVip))
                  BuildVipImage()
                else
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    clipBehavior: Clip.hardEdge,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        //  color: const Color(0x805138FF),
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image:
                                ExactAssetImage(Assets.imgAnchorDefaultAvatar),
                            fit: BoxFit.cover)),
                    foregroundDecoration: BoxDecoration(
                        // color: const Color(0x805138FF),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(path),
                            fit: BoxFit.cover)),
                  ),
                if (isVip && (!logic.state.userVip))
                  Center(
                    child: Image.asset(
                      Assets.imgVipLock,
                      matchTextDirection: true,
                      width: 30,
                      height: 30,
                    ),
                  ),
                if (isVip)
                  PositionedDirectional(
                    top: 5,
                    start: 4,
                    child: Image.asset(
                      Assets.imgIconVip,
                      width: 32,
                      height: 16,
                    ),
                  ),
              ],
            ))
        : Container(
            width: double.maxFinite,
            height: double.maxFinite,
            clipBehavior: Clip.hardEdge,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                // color: const Color(0x805138FF),
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: ExactAssetImage(Assets.imgAnchorDefaultAvatar),
                    fit: BoxFit.cover)),
            foregroundDecoration: path != ""
                ? BoxDecoration(
                    // color: const Color(0x805138FF),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(path),
                        fit: BoxFit.cover))
                : const BoxDecoration(),
          );
  }
}

class CircularRectTween extends RectTween {
  CircularRectTween({required Rect begin, required Rect end})
      : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    double centerX = lerpDouble(begin!.center.dx, end!.center.dx, t)!;
    double centerY = lerpDouble(begin!.center.dy, end!.center.dy, t)!;
    double width = lerpDouble(begin!.width, end!.width, t)!;
    double height = lerpDouble(begin!.height, end!.height, t)!;
    return Rect.fromCenter(
        center: Offset(centerX, centerY), width: width, height: height);
  }
}
