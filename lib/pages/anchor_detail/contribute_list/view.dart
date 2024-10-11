part of contribute_list_page;

@RouteName(AppPages.contributeList)
class ContributeListPage extends GetView<ContributeListLogic> {
  const ContributeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: Tr.app_ranking.tr, isSetBg: false),
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.splashBg,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
              top: 0, start: 0, end: 0, child: Image.asset(Assets.imgTabTopBg)),
          GetBuilder<ContributeListLogic>(
              init: ContributeListLogic(),
              builder: (logic) {
                return Container(
                  margin: EdgeInsetsDirectional.only(
                      start: 18.w, end: 18.w, top: 15 + 70, bottom: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          avatarB(logic),
                          avatarA(logic),
                          avatarC(logic),
                        ],
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
          width: 100.w,
          height: 98,
          foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                  matchTextDirection: true,
                  fit: BoxFit.fill,
                  image: ExactAssetImage(Assets.imgSortA))),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              logic.sortAAvatar == null
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(100)),
                      width: 60,
                      height: 60,
                      child: UnconstrainedBox(
                        child: Image.asset(
                          Assets.imgSortAvatar,
                          width: 60,
                          height: 60,
                          matchTextDirection: true,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(100),
                      child: cachedImage(logic.sortAAvatar?.showPortrait ?? "",
                          width: 80, height: 80),
                    )
            ],
          ),
        ),
        Container(
          width: 115.w,
          height: 90,
          margin: const EdgeInsetsDirectional.only(top: 12),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12), topEnd: Radius.circular(12))),
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
                    maxFontSize: 16,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              if (logic.sortAAvatar != null)
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 2),
                        child: Image.asset(
                          Assets.imgSmallPickLove,
                          width: 18,
                          height: 18,
                          matchTextDirection: true,
                        ),
                      ),
                      Flexible(
                          child: AutoSizeText(
                        "${logic.sortAAvatar?.amount ?? 0}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        maxFontSize: 18,
                        minFontSize: 8,
                        style: TextStyle(
                            color: const Color(0xFFFECE51),
                            fontSize: 18,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.normal),
                      )),
                    ],
                  ),
                )
            ],
          ),
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
          height: 98,
          foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                  matchTextDirection: true,
                  fit: BoxFit.fill,
                  image: ExactAssetImage(Assets.imgSortB))),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              logic.sortBAvatar == null
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(100)),
                      width: 60,
                      height: 60,
                      child: UnconstrainedBox(
                        child: Image.asset(
                          Assets.imgSortAvatar,
                          width: 60,
                          height: 60,
                          matchTextDirection: true,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(100),
                      child: cachedImage(logic.sortBAvatar?.showPortrait ?? "",
                          width: 60, height: 60),
                    )
            ],
          ),
        ),
        Container(
          width: 102.w,
          height: 80,
          margin: const EdgeInsetsDirectional.only(top: 5),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12), topEnd: Radius.circular(12))),
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
                    maxFontSize: 16,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              if (logic.sortBAvatar != null)
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsetsDirectional.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 2),
                        child: Image.asset(
                          Assets.imgSmallPickLove,
                          width: 18,
                          height: 18,
                          matchTextDirection: true,
                        ),
                      ),
                      Flexible(
                          child: AutoSizeText(
                        "${logic.sortBAvatar?.amount ?? 0}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        maxFontSize: 16,
                        minFontSize: 8,
                        style: TextStyle(
                            color: const Color(0xFF6FEAF4),
                            fontSize: 16,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.normal),
                      )),
                    ],
                  ),
                )
            ],
          ),
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
          height: 98,
          foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                  matchTextDirection: true,
                  fit: BoxFit.fill,
                  image: ExactAssetImage(Assets.imgSortC))),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              logic.sortCAvatar == null
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(100)),
                      width: 60,
                      height: 60,
                      child: UnconstrainedBox(
                        child: Image.asset(
                          Assets.imgSortAvatar,
                          width: 60,
                          height: 60,
                          matchTextDirection: true,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(100),
                      child: cachedImage(logic.sortCAvatar?.showPortrait ?? "",
                          width: 60, height: 60),
                    )
            ],
          ),
        ),
        Container(
          width: 102.w,
          height: 80,
          margin: const EdgeInsetsDirectional.only(top: 0),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12), topEnd: Radius.circular(12))),
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
                    maxFontSize: 16,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              if (logic.sortCAvatar != null)
                Container(
                    // color: Colors.blueAccent,
                    width: double.maxFinite,
                    margin: const EdgeInsetsDirectional.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 2),
                          child: Image.asset(
                            Assets.imgSmallPickLove,
                            width: 18,
                            height: 18,
                            matchTextDirection: true,
                          ),
                        ),
                        Flexible(
                            child: AutoSizeText(
                          "${logic.sortCAvatar?.amount ?? 0}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 16,
                          minFontSize: 8,
                          style: TextStyle(
                              color: const Color(0xFFEE7F4E),
                              fontSize: 16,
                              fontFamily: AppConstants.fontsBold,
                              fontWeight: FontWeight.normal),
                        )),
                      ],
                    ))
            ],
          ),
        ),
      ],
    );
  }
}
