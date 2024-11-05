part of media_page;

@RouteName(AppPages.medias)
class MediasPage extends GetView<MediasLogic> {
  const MediasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BaseAppBar(
        leading: toBack,
        actions: [toReport],
      ),
      body: const Body(),
    );
  }

  Widget get toBack => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Get.back(),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              Assets.iconCloseDialog,
              width: 34,
              height: 34,
            )
          ],
        ),
      );

  Widget get toReport => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => ARoutes.toReport(uid: "", index: "", type: "2"),
        child: Container(
          margin: const EdgeInsetsDirectional.only(end: 10),
          child: Image.asset(
            Assets.iconReportIcon,
            matchTextDirection: true,
            width: 34,
            height: 34,
          ),
        ),
      );
}
