import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_translations.dart';
import 'package:oliapro/pages/widget/app_ring_ctrl.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/observer/history_router_observer.dart';
import 'package:oliapro/widget/app_init_builder.dart';
import 'package:oliapro/widget/refresh_confige/footer.dart';
import 'package:oliapro/widget/refresh_confige/header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return AppRingCtrl(RefreshConfiguration(
      headerBuilder: () => const Header(),
      footerBuilder: () => const Footer(),
      hideFooterWhenNotFull: true,
      enableBallisticLoad: true,
      child: ScreenUtilInit(
          enableScaleText: () => false,
          designSize: const Size(375.0, 812.0),
          builder: (context, _) => materialApp()),
    ));
  }

  Widget materialApp() {
    return GetMaterialApp(
      localizationsDelegates: const [
        RefreshLocalizations.delegate,
      ],
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      translations: AppTrans(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale("en"),
      getPages: AppPages.routes,
      navigatorObservers: [
        AppPages.observer,
        routeHistoryObserver,
      ],
      builder: (context, child) =>
          MediaQuery.withNoTextScaling(child: AppInitBuilder(child)),
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // scaffoldBackgroundColor: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent),
        tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
      ),
      routingCallback: (routing) {
        debugPrint("routing:${routing?.current}");
      },
      initialRoute: AppPages.initial,
    );
  }
}
