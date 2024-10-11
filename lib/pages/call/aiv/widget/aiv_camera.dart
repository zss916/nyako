import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/pages/call/aiv/index.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/widget/app_net_image.dart';

class AivCamera extends StatelessWidget {
  final AivLogic logic;

  const AivCamera(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: (logic.hadCameraInit && logic.cameraController != null)
            ? Center(
                child: Transform.scale(
                  scale: logic.cameraController!.value.aspectRatio /
                      (Get.width / Get.height),
                  child: AspectRatio(
                    aspectRatio: logic.cameraController!.value.aspectRatio,
                    child:
                        Center(child: CameraPreview(logic.cameraController!)),
                  ),
                ),
              )
            : AppNetImage(
                UserInfo.to.userLogin?.portrait ?? "",
              ));
  }
}
