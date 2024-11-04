import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/widget/app_media_view_page.dart';
import 'package:oliapro/pages/widget/interactiveviewer_gallery/interactiveviewer_gallery.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:video_player/video_player.dart';

///图片（普通无举报）
showPreview(List<String>? sourceList,
    {int initIndex = 0,
    String uid = "",
    int type = -1,
    String? mid,
    bool isFile = false}) {
  if (sourceList == null || sourceList.isEmpty) return;
  Get.dialog(ZoomIn(
    duration: const Duration(milliseconds: 250),
    child: DisplayGesture(
      cancelFunc: () {},
      uid: uid,
      index: initIndex,
      reportType: 0,
      cancelReport: true,
      child: InteractiveviewerGallery<String>(
        sources: sourceList,
        cancelFunc: () {},
        initIndex: initIndex,
        itemBuilder: (BuildContext context, int index, bool isFocus) {
          return MPreviewImageItem(sourceList[index], isFile: isFile);
        },
        onPageChanged: (int pageIndex) {},
      ),
    ),
  ));
}

class MPreviewImageItem extends StatefulWidget {
  final String source;
  final Function? cancelFunc;
  final bool? isFile;
  const MPreviewImageItem(this.source, {Key? key, this.cancelFunc, this.isFile})
      : super(key: key);
  @override
  State<MPreviewImageItem> createState() => _MPreviewImageItemState();
}

class _MPreviewImageItemState extends State<MPreviewImageItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.isFile == true
          ? Image.file(
              File(widget.source),
              fit: BoxFit.cover,
            )
          : cachedImage(widget.source,
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite),
    );
  }
}

class DisplayGesture extends StatefulWidget {
  final Function? cancelFunc;
  final Widget child;
  final String uid;
  final int index;
  final int reportType;
  final String? mid;

  ///视频或照片的id
  final bool cancelReport;

  const DisplayGesture(
      {Key? key,
      required this.child,
      required this.uid,
      required this.index,
      required this.reportType,
      required this.cancelReport,
      this.cancelFunc,
      this.mid})
      : super(key: key);

  @override
  State<DisplayGesture> createState() => _DisplayGestureState();
}

class _DisplayGestureState extends State<DisplayGesture> {
  List<PointerEvent> displayModelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: GetPlatform.isIOS == true ? false : true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () => Get.back(),
          child: UnconstrainedBox(
            child: Image.asset(
              Assets.iconBack,
              width: 30,
              height: 30,
              matchTextDirection: true,
              color: Colors.white,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          widget.cancelReport
              ? const SizedBox.shrink()
              : _report(widget.uid, widget.index, widget.reportType,
                  mid: widget.mid),
        ],
      ),
      backgroundColor: Colors.black,
      body: Listener(
        onPointerDown: (PointerDownEvent event) {
          displayModelList.add(event);
          if (mounted == true) {
            setState(() {});
          }
        },
        onPointerMove: (PointerMoveEvent event) {
          for (int i = 0; i < displayModelList.length; i++) {
            if (displayModelList[i].pointer == event.pointer) {
              displayModelList[i] = event;
              if (mounted == true) {
                setState(() {});
              }
              return;
            }
          }
        },
        onPointerUp: (PointerUpEvent event) {
          for (int i = 0; i < displayModelList.length; i++) {
            if (displayModelList[i].pointer == event.pointer) {
              displayModelList.removeAt(i);
              if (mounted == true) {
                setState(() {});
              }
              return;
            }
          }
        },
        child: Stack(
          children: [
            widget.child,
            ...displayModelList.map((PointerEvent e) {
              return Positioned(
                left: e.position.dx - 30,
                top: e.position.dy - 30,
                child: const SizedBox.shrink(),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  _report(String uid, int index, int type, {String? mid}) {
    //debugPrint("report===>>B type: $type , mid: ${mid},");
    return InkWell(
      onTap: () => ARoutes.toReport(
          uid: uid,
          channelID: mid,
          index: index.toString(),
          type: type.toString()),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Image.asset(
          Assets.iconReportIcon,
          matchTextDirection: true,
          //color: Colors.white,
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}

class MVideoItem extends StatefulWidget {
  final HostMedia source;
  final bool isFocus;

  const MVideoItem(this.source, this.isFocus, {Key? key}) : super(key: key);

  @override
  State<MVideoItem> createState() => _MVideoItemState();
}

class _MVideoItemState extends State<MVideoItem> {
  VideoPlayerController? _controller;
  late VoidCallback listener;
  String? localFileName;

  _MVideoItemState() {
    listener = () {
      if (mounted == true) {
        setState(() {});
      }
    };
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.source.path ?? ""),
        videoPlayerOptions: VideoPlayerOptions(
            mixWithOthers: true, allowBackgroundPlayback: true));
    _controller?.addListener(listener);
    _controller?.setLooping(false);
    await _controller?.initialize();
    if (mounted == true) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(listener);
    _controller?.pause();
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MVideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFocus && !widget.isFocus) {
      _controller?.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("=====>>>>  ${_controller!.value.aspectRatio}");
    return _controller?.value.isInitialized == true
        ? Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (mounted == true) {
                    setState(() {
                      _controller?.value.isPlaying == true
                          ? _controller?.pause()
                          : _controller?.play();
                    });
                  }
                },
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio >= 1
                      ? 9 / 16
                      : _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
              (_controller?.value.isPlaying == true)
                  ? ((_controller?.value.position.inMilliseconds ?? 0) > 0
                      ? const SizedBox.shrink()
                      : const Center(
                          child: CircularProgressIndicator(),
                        ))
                  : const SizedBox.shrink(),
              _controller?.value.isPlaying == true
                  ? const SizedBox.shrink()
                  : const IgnorePointer(
                      ignoring: true,
                      child: Icon(
                        Icons.play_arrow,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
            ],
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              cachedImage(
                  // '${widget.source.path ?? ''}${MonaConstants.videoCoverUrl}',
                  widget.source.cover ?? "",
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: double.maxFinite),
              (_controller?.value.isInitialized == true &&
                      _controller?.value.isPlaying != true)
                  ? IconButton(
                      onPressed: () {
                        if (_controller?.value.isPlaying != true) {
                          _controller?.play();
                        }
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 60,
                        color: Colors.white,
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          );
  }
}

///主播详情的图片和视频举报
showAnchorDetailPreview(List<HostMedia>? sourceList, BuildContext context,
    {int initIndex = 0, String uid = "", HostDetail? data}) {
  String mMid = (sourceList ?? [])[initIndex].mid.toString();
  int? mType = (sourceList ?? [])[initIndex].type ?? -1;
  showVideoPreview(sourceList, context,
      initIndex: initIndex,
      uid: uid,
      type: mType,
      mid: mMid,
      reportType: 2,
      data: data);
}

///图片和影片(主播详情)
///reportType : 0举报主播，1举报动态，2举报封面视频或主播图片视频,3举报app
showVideoPreview(List<HostMedia>? sourceList, BuildContext context,
    {int initIndex = 0,
    String uid = "",
    int type = -1,
    String? mid,
    int? reportType,
    bool cancelReport = false,
    HostDetail? data}) {
  if (sourceList == null || sourceList.isEmpty) return;

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => AppFullScreenSliderPage.hostMedia(
                list: sourceList,
                position: initIndex,
                reportType: reportType,
                uid: uid,
                data: data,
              )));
}
