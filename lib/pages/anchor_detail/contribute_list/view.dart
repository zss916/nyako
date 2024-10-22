part of contribute_list_page;

@RouteName(AppPages.contributeList)
class ContributeListPage extends GetView<ContributeListLogic> {
  const ContributeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_contribution_list.tr,
        isDark: false,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
              top: 0,
              start: 0,
              end: 0,
              child: Image.asset(
                Assets.iconRankingBg,
                matchTextDirection: true,
              )),
          GetBuilder<ContributeListLogic>(
              init: ContributeListLogic(),
              builder: (logic) {
                return Container(
                  margin: EdgeInsetsDirectional.only(
                      start: 0.w, end: 0.w, top: 110, bottom: 5),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsetsDirectional.only(start: 25.w, end: 25.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            avatarB(logic),
                            avatarA(logic),
                            avatarC(logic),
                          ],
                        ),
                      ),
                      Expanded(
                          child: BuildContributions(logic, logic.contributions))
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget avatarA(ContributeListLogic logic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120.w,
          height: 120,
          foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                  matchTextDirection: true,
                  fit: BoxFit.fill,
                  image: ExactAssetImage(Assets.iconSortA))),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              logic.sortAAvatar == null
                  ? Container(
                      margin: const EdgeInsetsDirectional.only(start: 3),
                      clipBehavior: Clip.hardEdge,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(100)),
                      width: 85,
                      height: 85,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(
                            Assets.iconSortAvatar,
                            width: 60,
                            height: 60,
                            matchTextDirection: true,
                          )
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(100),
                      child: cachedImage(logic.sortAAvatar?.showPortrait ?? "",
                          width: 70, height: 70),
                    )
            ],
          ),
        ),
        (logic.sortAAvatar != null)
            ? Container(
                width: 115.w,
                padding: const EdgeInsetsDirectional.only(
                    start: 10, end: 10, bottom: 20),
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(12),
                        topEnd: Radius.circular(12))),
                child: Column(
                  children: [
                    if (logic.sortAAvatar != null)
                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.only(top: 10),
                        child: AutoSizeText(
                          (logic.sortAAvatar?.showNickName ?? "--"),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          maxFontSize: 13,
                          minFontSize: 13,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13),
                        ),
                      ),
                    if (logic.sortAAvatar != null)
                      Container(
                        margin: const EdgeInsetsDirectional.only(
                            top: 10, start: 4, end: 4),
                        child: Flexible(
                            child: AutoSizeText(
                          "${logic.sortAAvatar?.amount ?? 0}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 15,
                          minFontSize: 8,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: AppConstants.fontsBold,
                              fontWeight: FontWeight.normal),
                        )),
                      )
                  ],
                ),
              )
            : const SizedBox(
                height: 80,
              ),
      ],
    );
  }

  Widget avatarB(ContributeListLogic logic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100.w,
          height: 100,
          foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                  matchTextDirection: true,
                  fit: BoxFit.fill,
                  image: ExactAssetImage(Assets.iconSortB))),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              logic.sortBAvatar == null
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(100)),
                      width: 70,
                      height: 70,
                      child: UnconstrainedBox(
                        child: Image.asset(
                          Assets.iconSortAvatar,
                          width: 60,
                          height: 60,
                          matchTextDirection: true,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(100),
                      child: cachedImage(logic.sortBAvatar?.showPortrait ?? "",
                          width: 70, height: 70),
                    )
            ],
          ),
        ),
        (logic.sortBAvatar != null)
            ? Container(
                width: 102.w,
                margin: const EdgeInsetsDirectional.only(top: 0),
                padding: const EdgeInsetsDirectional.only(
                    start: 10, end: 10, bottom: 20),
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(12),
                        topEnd: Radius.circular(12))),
                child: Column(
                  children: [
                    if (logic.sortBAvatar != null)
                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.only(top: 10),
                        child: AutoSizeText(
                          logic.sortBAvatar?.showNickName ?? "--",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          maxFontSize: 13,
                          minFontSize: 13,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13),
                        ),
                      ),
                    if (logic.sortBAvatar != null)
                      Container(
                        width: double.maxFinite,
                        alignment: AlignmentDirectional.center,
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5),
                        margin: const EdgeInsetsDirectional.only(
                            top: 10, start: 4, end: 4),
                        child: Flexible(
                            child: AutoSizeText(
                          "${logic.sortBAvatar?.amount ?? 0}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 15,
                          minFontSize: 8,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: AppConstants.fontsBold,
                              fontWeight: FontWeight.normal),
                        )),
                      )
                  ],
                ),
              )
            : const SizedBox(
                height: 80,
              ),
      ],
    );
  }

  Widget avatarC(ContributeListLogic logic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100.w,
          height: 100,
          foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                  matchTextDirection: true,
                  fit: BoxFit.fill,
                  image: ExactAssetImage(Assets.iconSortC))),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              logic.sortCAvatar == null
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(100)),
                      width: 70,
                      height: 70,
                      child: UnconstrainedBox(
                        child: Image.asset(
                          Assets.iconSortAvatar,
                          width: 60,
                          height: 60,
                          matchTextDirection: true,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(100),
                      child: cachedImage(logic.sortCAvatar?.showPortrait ?? "",
                          width: 70, height: 70),
                    )
            ],
          ),
        ),
        (logic.sortCAvatar != null)
            ? Container(
                width: 102.w,
                margin: const EdgeInsetsDirectional.only(top: 0),
                padding: const EdgeInsetsDirectional.only(
                    start: 10, end: 10, bottom: 20),
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(12),
                        topEnd: Radius.circular(12))),
                child: Column(
                  children: [
                    if (logic.sortCAvatar != null)
                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.only(top: 10),
                        child: AutoSizeText(
                          logic.sortCAvatar?.showNickName ?? "--",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          maxFontSize: 13,
                          minFontSize: 13,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13),
                        ),
                      ),
                    if (logic.sortCAvatar != null)
                      Container(
                        // color: Colors.blueAccent,
                        width: double.maxFinite,
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.only(
                            top: 10, start: 4, end: 4),
                        child: Flexible(
                            child: AutoSizeText(
                          "${logic.sortCAvatar?.amount ?? 0}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 15,
                          minFontSize: 8,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: AppConstants.fontsBold,
                              fontWeight: FontWeight.normal),
                        )),
                      )
                  ],
                ),
              )
            : const SizedBox(
                height: 80,
              ),
      ],
    );
  }
}
