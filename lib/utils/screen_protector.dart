import 'package:screen_protector/screen_protector.dart';

class ScreenProtectorUtil  {

  static on() async{
    await ScreenProtector.protectDataLeakageOn();
  }

  static off() async{
    await ScreenProtector.protectDataLeakageOff();
  }

}
