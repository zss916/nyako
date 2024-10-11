import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/match/result/widget/triangle.dart';

class BuildPreview extends StatefulWidget {
  const BuildPreview({super.key});

  @override
  State<BuildPreview> createState() => _BuildPreviewState();
}

class _BuildPreviewState extends State<BuildPreview> {
  CameraController? cameraController;
  bool hadCameraInit = false;
  bool closePreview = false;
  double width = 102;
  double height = 152;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    super.dispose();
    if (cameraController != null) {
      cameraController?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: _localPreview(),
    );
  }

  // 生成本地预览
  Widget _localPreview() {
    return (hadCameraInit && cameraController != null && !closePreview)
        ? SizedBox(
            width: width,
            height: height,
            child: Stack(children: <Widget>[
              Center(
                child: Transform.scale(
                  scale: cameraController!.value.aspectRatio / (width / height),
                  child: AspectRatio(
                    aspectRatio: cameraController!.value.aspectRatio,
                    child: Center(child: CameraPreview(cameraController!)),
                  ),
                ),
              ),
              PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        closePreview = true;
                      });
                    },
                    child: Image.asset(
                      matchTextDirection: true,
                      Assets.imgCloseDialog,
                      width: 24,
                      height: 24,
                    ),
                  )),
            ]),
          )
        : Container(
            width: width,
            height: height,
            color: Colors.transparent,
          );
  }

  Widget buildTriangle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          closePreview = true;
        });
      },
      child: Stack(
        children: [
          const Triangle(),
          PositionedDirectional(
              top: 3,
              end: 3,
              child: Image.asset(
                Assets.imgCloseDialog,
                width: 8,
                height: 8,
              ))
        ],
      ),
    );
  }

  void initCamera({bool front = true}) async {
    await cameraController?.dispose();
    final cameras = await availableCameras();
    CameraDescription camera = cameras.last;
    cameras.forEach((element) {
      if (element.lensDirection == CameraLensDirection.front && front) {
        camera = element;
      }
      if (element.lensDirection == CameraLensDirection.back && !front) {
        camera = element;
      }
    });
    cameraController = CameraController(camera, ResolutionPreset.low);
    await cameraController?.initialize();
    hadCameraInit = true;
    setState(() {});
  }
}
