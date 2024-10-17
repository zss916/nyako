part of 'index.dart';

@RouteName(AppPages.accountCache)
class AccountCachePage extends GetView<AccountCacheLogic> {
  AppLoginEntity? get data => LoginCache.getLastLogin();

  const AccountCachePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        isSetBg: false,
        backgroundColor: Colors.transparent,
        leading: const SizedBox.shrink(),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsetsDirectional.all(10),
              child: Image.asset(
                Assets.iconClosePage,
                width: 30,
                height: 30,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: const Color(0xFFF3FCFE),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            PositionedDirectional(
                top: 0,
                start: 0,
                end: 0,
                child: Image.asset(
                  Assets.iconAccountLoginBg,
                  matchTextDirection: true,
                )),
            Column(
              children: [
                Container(
                  margin:
                      const EdgeInsetsDirectional.only(top: 100, bottom: 10),
                  child: Image.asset(
                    Assets.iconSmallLogo,
                    width: 52,
                    height: 52,
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 10, end: 10, bottom: 0),
                  child: Text(
                    Tr.app_login_username.tr,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 10,
                    end: 10,
                  ),
                  child: Text(
                    Tr.app_login_top_title.trArgs([AppConstants.appName]),
                    maxLines: 1,
                    style: const TextStyle(
                        color: Color(0xFF7D6E87),
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 105,
                  height: 105,
                  margin: const EdgeInsetsDirectional.only(top: 45),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(100),
                      border: Border.all(width: 4, color: Colors.white)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: cachedImage(data?.profileUrl ?? ""),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      top: 15, start: 10, end: 10, bottom: 10),
                  child: AutoSizeText(
                    data?.nickName ?? "--",
                    maxLines: 1,
                    maxFontSize: 16,
                    minFontSize: 10,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  child: LoginBtn(
                    child: Center(
                      child: Text(
                        Tr.app_account_login.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    controller.onSubmit();
                  },
                ),
                Container(
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 35),
                  child: InkWell(
                    //splashColor: const Color(0xFF7934F0),
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      ARoutes.toAccountLogin();
                    },
                    child: Container(
                      //color: Colors.white12,
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 12, vertical: 12),
                      margin: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Text(
                        Tr.appUseOtherAccount.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF9341FF),
                            color: Color(0xFF9341FF),
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      top: 30, start: 15, end: 15),
                  child: LoginCheck(
                    UserInfo.to.getCheck(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
