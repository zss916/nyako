part of local_page;

@RouteName(AppPages.callOut)
class LocalPage extends GetView<LocalLogic> {
  const LocalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
          leading: const SizedBox.shrink(),
          systemOverlayStyle: lightBarStyle,
        ),
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: GetBuilder<LocalLogic>(
            init: LocalLogic(), builder: (logic) => Body(logic)),
      ),
    );
  }
}
