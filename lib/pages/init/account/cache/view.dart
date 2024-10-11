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
        leading: Get.arguments == true ? const SizedBox.shrink() : null,
      ),
      backgroundColor: AppColors.splashBg,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(bottom: 40.h),
                child: Image.asset(
                  Assets.imgCacheLoginTop,
                  matchTextDirection: true,
                  fit: BoxFit.cover,
                  width: Get.width,
                  height: 370.h,
                ),
              ),
              PositionedDirectional(
                  bottom: 0,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: const Color(0x4DAC53FB),
                        borderRadius: BorderRadiusDirectional.circular(100),
                        border: Border.all(
                            width: 1, color: const Color(0xFF8239FF))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: cachedImage(data?.profileUrl ?? ""),
                    ),
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
                top: 15, start: 10, end: 10, bottom: 10),
            child: AutoSizeText(
              data?.nickName ?? "--",
              maxLines: 1,
              maxFontSize: 20,
              minFontSize: 15,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold),
            ),
          ),
          /*Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
                color: const Color(0x33FFF890),
                borderRadius: BorderRadiusDirectional.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data?.diamondCount ?? "--",
                  style: const TextStyle(
                      color: Color(0xFFFFF890),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 3),
                  child: Image.asset(
                    Assets.imgDiamond,
                    width: 16,
                    height: 16,
                    matchTextDirection: true,
                  ),
                )
              ],
            ),
          ),*/
          AnimatedButton(
            isAnimate: false,
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
            onCall: () {
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
                    horizontal: 10, vertical: 8),
                child: Text(
                  Tr.appUseOtherAccount.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin:
                const EdgeInsetsDirectional.only(top: 0, start: 15, end: 15),
            child: LoginCheck(
              UserInfo.to.getCheck(),
            ),
          ),
        ],
      ),
    );
  }
}
