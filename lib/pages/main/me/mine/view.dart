part of 'index.dart';

class MePage extends GetView<MeLogic> {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MeBody(controller),
    );
  }
}
