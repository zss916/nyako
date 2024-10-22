part of 'index.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 0,
        leading: const SizedBox.shrink(),
        systemOverlayStyle: darkBarStyle,
      ),
      backgroundColor: Colors.white,
      body: HomeBody(),
    );
  }
}
