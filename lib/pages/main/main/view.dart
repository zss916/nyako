part of 'index.dart';

@RouteName(AppPages.main)
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with RouteAware, WidgetsBindingObserver {
  late StreamSubscription<BackHomeEvent> backHomeEvent;
  late final PageController pageController = PageController(initialPage: 0);
  int select = 0;
  bool showMsg = false;
  int showMsgNum = 0;

  @override
  void initState() {
    super.initState();
    AppPayCacheManager.clearValidOrder();
    WidgetsBinding.instance.addObserver(this);

    ///回到首页
    backHomeEvent = AppEventBus.eventBus.on<BackHomeEvent>().listen((event) {
      AppPages.isAppBackground = false;
      pageController.jumpToPage(0);
      setState(() {
        select = 0;
        handleNavBarTap(0);
      });
    });

    StorageService.to.eventBus.on<EventUnRead>().listen((event) {
      if (mounted) {
        setState(() {
          showMsgNum = event.unReadNum;
          showMsg = (event.unReadNum != 0);
        });
      }
    });

    PddUtil.instance.mainInit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppPages.observer.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    backHomeEvent.cancel();
    pageController.dispose();
    AppPages.observer.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    AppPayCacheManager.checkOrderList();
  }

  //App 的⽣命周期
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        AppPages.isAppBackground = false;
        AppSocketManager.to.init();
        PddUtil.instance.mainInit();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        AppPages.isAppBackground = true;
        AppSocketManager.to.breakenSocket();
        PddUtil.instance.mainStop();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return contentBody();
  }

  Widget contentBody() => Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned.fill(
            child: BuildPopScope(
              child: Scaffold(
                backgroundColor: Colors.white,
                extendBody: true,
                body: PageView(
                  pageSnapping: false,
                  scrollBehavior: null,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: const [
                    HomePage(),
                    DiscoverPage(),
                    MsgListPage(),
                    MatchPage(),
                    //AppKeepAlivePage(),
                    MePage()
                  ],
                ),

                ///elevation 不为0 就会有一层黑色透明的
                bottomNavigationBar: CustomNavigationBar(
                  currentIndex: select,
                  elevation: 0,
                  strokeColor: Colors.transparent,
                  scaleFactor: 0.1,
                  iconSize: 35,
                  items: [
                    CustomNavigationBarItem(
                      icon: Image.asset(
                        Assets.iconTabHome,
                        matchTextDirection: true,
                      ),
                      selectedIcon: Image.asset(
                        Assets.iconTabHomeS,
                        matchTextDirection: true,
                      ),
                    ),
                    CustomNavigationBarItem(
                        icon: Image.asset(
                          Assets.iconTabDiscover,
                          matchTextDirection: true,
                        ),
                        selectedIcon: Image.asset(
                          Assets.iconTabDiscoverS,
                          matchTextDirection: true,
                        )),
                    CustomNavigationBarItem(
                      icon: Image.asset(
                        Assets.iconTabMsg,
                        matchTextDirection: true,
                      ),
                      selectedIcon: Image.asset(
                        Assets.iconTabMsgS,
                        matchTextDirection: true,
                      ),
                      showBadge: showMsg,
                      badgeCount: showMsgNum,
                    ),
                    CustomNavigationBarItem(
                        icon: Image.asset(
                          Assets.iconTabMatch,
                          matchTextDirection: true,
                        ),
                        selectedIcon: Image.asset(
                          Assets.iconTabMatchS,
                          matchTextDirection: true,
                        )),
                    CustomNavigationBarItem(
                        icon: Image.asset(
                          Assets.iconTabProfile,
                          matchTextDirection: true,
                        ),
                        selectedIcon: Image.asset(
                          Assets.iconTabProfileS,
                          matchTextDirection: true,
                        )),
                  ],
                  onTap: (i) {
                    setState(() {
                      select = i;
                      handleNavBarTap(i);
                    });
                  },
                ),
              ),
            ),
          ),
          // const BuildShowVipOnline(),
        ],
      );

  // tab栏动画
  void handleNavBarTap(int index) {
    // 有这个事件说明app不是后台
    AppPages.isAppBackground = false;
    if (safeFind<MainLogic>()?.currentIndex == index) return;
    safeFind<MainLogic>()?.currentIndex = index;
    pageController.jumpToPage(index);

    if (index == 2) {
      StorageService.to.objectBoxMsg.refreshUnreadNum();
      // 这里通知消息栏更新一下
      StorageService.to.eventBus.fire(EventMsgClear(0));
    }
    if (index != 1) {
      StorageService.to.eventBus.fire('pauseDiscover');
    }

    if (index == 1) {
      safeFind<MomentLogic>()?.shuffleDiscover();
    }

    if (index == 0) {
      safeFind<HomeLogic>()?.sort();
    }

    if (index == 3) {
      //StorageService.to.eventBus.fire("vipRefresh");
      BgmControl.callInBgmStart();
    } else {
      BgmControl.callInBgmClose();
    }

    ///游客登录弹窗
    if (index == 4) {
      //只有账号登录才有
      if (!UserInfo.to.getVisitorPsdDialog() &&
          LoginCache.getLastLogin()?.isGoogle != true) {
        String password = UserInfo.to.getVisitorPassword();
        String account = UserInfo.to.getVisitorAccount();
        ChangePasswordDialog2.show(account, password, () {});
      }
    }
  }
}
