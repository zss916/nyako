part of 'index.dart';

@RouteName(AppPages.public)
class PublicPage extends GetView<PublicLogic> {
  const PublicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(leading: toBack, title: "", actions: [toPublic]),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: PublicBody(controller),
    );
  }

  Widget get toPublic => GestureDetector(
      onTap: () {
        controller.toPublic(content: controller.ctl.text);
      },
      child: Center(
        child: Container(
          width: 72,
          height: 35,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  stops: [
                    0.6,
                    1
                  ],
                  colors: [
                    Color(0xFFFF3878),
                    Color(0xFFFFCD1D),
                  ]),
              borderRadius: BorderRadiusDirectional.circular(50)),
          margin: const EdgeInsetsDirectional.only(end: 10),
          child: UnconstrainedBox(
            child: Image.asset(
              "Assets.imagePublic",
              width: 18,
              height: 17,
              color: Colors.white,
              matchTextDirection: true,
            ),
          ),
        ),
      )).onLabel(label: SemanticsLabel.publish);

  Widget get toBack => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Get.back(),
        child: UnconstrainedBox(
          child: Image.asset(Assets.imgCloseDialog,
              width: 30, height: 30, matchTextDirection: true),
        ),
      ).onLabel(label: SemanticsLabel.back);
}
