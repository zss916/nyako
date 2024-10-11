part of 'index.dart';

class EditLogic extends GetxController {
  InfoState state = InfoState();

  List<Map<String, String>> listData = [
    {'title': Tr.app_details_name.tr, 'type': 'nickname'},
    {'title': Tr.app_details_sex.tr, 'type': 'gender'},
    {'title': Tr.app_details_birth.tr, 'type': 'birth'},
    {'title': Tr.app_details_sign.tr, 'type': 'intro'},
    {'title': Tr.app_base_avatar.tr, 'type': 'portrait'},
  ];

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  void loadData() async {
    state.myDetail = UserInfo.to.myDetail;
    state.showNickname = state.myDetail?.nickname ?? '';
    state.showGender = state.myDetail?.gender ?? 1;
    state.showPortrait = state.myDetail?.portrait ?? '';
    state.showIntro = state.myDetail?.intro ?? '';
    state.showBirthday = state.myDetail?.birthday ?? 0;
    update();
  }

  void updateUser(
      {int? gender,
      String? nickname,
      String? portrait,
      String? intro,
      int? birthday}) async {
    Map<String, dynamic> requestData = {};
    if (gender != null) {
      requestData['gender'] = gender;
    }
    if (nickname != null) {
      requestData['nickname'] = nickname;
    }
    if (portrait != null) {
      requestData['portrait'] = portrait;
    }
    if (intro != null) {
      requestData['intro'] = intro;
    }
    if (birthday != null) {
      requestData['birthday'] = birthday;
    }

    await ProfileAPI.updateUser(map: requestData);
    if (nickname != null) {
      state.myDetail?.nickname = nickname;
      state.showNickname = nickname;
    }
    if (intro != null) {
      state.myDetail?.intro = intro;
      state.showIntro = intro;
    }
    if (birthday != null) {
      state.myDetail?.birthday = birthday;
      state.showBirthday = birthday;
    }
    if (gender != null) {
      state.myDetail?.gender = gender;
      state.showGender = gender;
      StorageService.to.saveHadSetGender();
    }
    if (portrait != null) {
      state.myDetail?.portrait = portrait;
      state.showPortrait = portrait;
    }
    LoginCache.update(nickName: nickname);
    StorageService.to.eventBus.fire(eventBusRefreshMe);
    update();
  }

  String setValue(String type) {
    var value = '';
    if (type == 'gender') {
      if (state.showGender == 1) {
        value = Tr.app_man.tr;
      } else {
        value = Tr.app_woman.tr;
      }
    } else if (type == 'birth') {
      if (state.showBirthday != 0) {
        value = dateFormat(state.showBirthday, formatStr: 'yyyy.MM.dd');
      } else {
        value = '--';
      }
    } else if (type == 'intro') {
      value = state.showIntro;
    } else {
      value = state.showNickname;
    }
    return value;
  }

  void clickAction(String type) async {
    switch (type) {
      case "nickname":
        showEditNickNameSheet(state.showNickname);
        break;
      case 'gender':
        showSelectGenderSheet();
        break;
      case 'birth':
        showEditBirth(state.showBirthday, (data) {
          updateUser(birthday: data);
        });
        break;
      case 'intro':
        showEditIntroSheet(state.showIntro);
        break;
      case 'portrait':
        changeAvatar();
        break;
    }
  }

  void changeAvatar() {
    AppChooseImageUtil(
        type: 0,
        callBack: (uploader, type, url, path) {
          switch (type) {
            case AppUploadType.cancel:
              {}
              break;
            case AppUploadType.begin:
              AppLoading.show();
              break;
            case AppUploadType.success:
              // debugPrint("showPortrait====>>>a $url");
              state.showPortrait = url ?? "";
              update();
              LoginCache.update(profile: url);
              updateUser(portrait: url);
              break;
            case AppUploadType.failed:
              AppLoading.dismiss();
              break;
          }
        }).openChooseDialog();
  }
}
