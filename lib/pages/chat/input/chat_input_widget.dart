import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/sheet_gift_list.dart';
import 'package:oliapro/entities/app_gift_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/utils/app_permission_handler.dart';
import 'package:oliapro/utils/app_voice_player.dart';
import 'package:oliapro/utils/image_update/app_choose_image_util.dart';
import 'package:oliapro/widget/app_click_widget.dart';
import 'package:oliapro/widget/app_keybord_logic.dart';
import 'package:oliapro/widget/app_voice_record.dart';
import 'package:oliapro/widget/gift/app_gift_list_view.dart';

import 'chat_input_controller.dart';

/// 聊天页面的下面的输入框
class ChatInputWidget extends StatefulWidget {
  final String userId;
  final String tag;

  const ChatInputWidget({super.key, required this.userId, required this.tag});

  @override
  State<StatefulWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget>
    with WidgetsBindingObserver, AppKeyboardLogic {
  late final ChatInputController _controller;
  late final ChatLogic _chatController;
  late final FocusNode _focusNode;

  /// 只有显示过键盘的时候才知道键盘高度
  bool hadKeyBordShow = false;
  double keyBordHeight = 278;

  bool get isSystemId => _chatController.herId == AppConstants.serviceId;
  late Function() listener;

  bool isInputEdit = true;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ChatInputController(widget.userId, tag: widget.tag));
    _chatController = Get.find<ChatLogic>(tag: widget.tag);
    _focusNode = FocusNode();
    listener = () {
      if (_focusNode.hasFocus) {
        _controller.isShowEmoji.value = false;
        _controller.isShowRecord.value = false;
      }
    };
    _focusNode.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('ChatInputWidget build');
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 15, top: 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              if (!isSystemId)
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsetsDirectional.only(
                      start: 16, end: 16, bottom: 10),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: [
                      pic(),
                      gift(),
                      call(),
                    ],
                  ),
                ),
              Row(
                children: [
                  isInputEdit ? voice() : input(),
                  isInputEdit
                      ? Expanded(
                          child: GestureDetector(
                          onTap: () {
                            if (_focusNode.hasFocus) {
                              _focusNode.unfocus();
                            } else {
                              _focusNode.requestFocus();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(
                                start: 2, end: 2, top: 3, bottom: 10),
                            padding: const EdgeInsetsDirectional.only(
                                start: 12, end: 12),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF4F5F6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            height: 48,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      focusNode: _focusNode,
                                      controller:
                                          _controller.textEditingController,
                                      maxLines: 1,
                                      minLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                          hintText:
                                              Tr.app_message_send_input.tr,
                                          hintStyle: const TextStyle(
                                              color: Color(0xFFBCB6C4),
                                              fontWeight: FontWeight.w400),
                                          hintMaxLines: 1,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 5),
                                  child: send(_controller),
                                ),
                              ],
                            ),
                          ),
                        ))
                      : Expanded(child: pressToSpeak()),
                  emjio(),
                ],
              ),
              Obx(() => _controller.isShowEmoji.value
                  ? showEmoji()
                  : const SizedBox.shrink()),
            ],
          ),
        ),
        /*Obx(() => _controller.isShowRecord.value
            ? showAudio()
            : const SizedBox.shrink()),*/
      ],
    );
  }

  @override
  void onKeyboardChanged(bool visible) {
    if (visible) {
      _controller.isShowEmoji.value = false;
      if (!hadKeyBordShow) {
        if (mounted) {
          setState(() {
            keyBordHeight = getKeyBordHeight(Get.context!);
          });
        }
        hadKeyBordShow = true;
      }
      Get.find<ChatLogic>(tag: widget.tag).scrollWhenMsgAdd(false);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(listener);
    _focusNode.dispose();
    super.dispose();
  }

  ///发送
  Widget send(ChatInputController logic) => AppClickWidget(
        onTap: () => logic.sendTextMsg(),
        child: Image.asset(
          Assets.iconChatSend,
          height: 26,
          width: 26,
          matchTextDirection: true,
          // fit: BoxFit.contain,
        ),
      );

  ///礼物
  Widget gift() {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        AppAudioPlayer().stop();
        _focusNode.unfocus();
        _controller.isShowEmoji.value = false;
        showGiftListSheet(
            child: AppGiftListView(
          choose: (GiftEntity gift) {
            //debugPrint("===>>> gift ==>${gift.toJson()}");
            _chatController.sendGift(gift);
          },
          herId: _controller.userId,
        ));
      },
      child: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 4, top: 4, bottom: 4, end: 8),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFE4E4E4)),
            borderRadius: BorderRadiusDirectional.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsetsDirectional.only(end: 4),
              padding: const EdgeInsetsDirectional.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(50),
                  color: const Color(0xFFFD7376)),
              child: Image.asset(
                Assets.iconInputGift,
                matchTextDirection: true,
                height: 18,
                width: 18,
              ),
            ),
            Text(
              Tr.app_message_type_gift.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  ///图片
  Widget pic() {
    return InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          AppAudioPlayer().stop();
          _focusNode.unfocus();
          _controller.isShowEmoji.value = false;
          _controller.isShowRecord.value = false;
          if (!_chatController.canSendMsg()) {
            _controller.askVip(anchorId: widget.userId);
            return;
          }
          AppChooseImageUtil(type: 1, callBack: _controller.upLoadCallBack)
              .openChooseDialog();
        },
        child: Container(
          padding: const EdgeInsetsDirectional.only(
              start: 4, top: 4, bottom: 4, end: 8),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: const Color(0xFFE4E4E4)),
              borderRadius: BorderRadiusDirectional.circular(30)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsetsDirectional.only(end: 4),
                padding: const EdgeInsetsDirectional.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(50),
                    color: const Color(0xFFFEA673)),
                child: Image.asset(
                  Assets.iconInputPic,
                  matchTextDirection: true,
                  height: 18,
                  width: 18,
                ),
              ),
              Text(
                Tr.app_message_type_photo.tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }

  ///拨打通话
  Widget call() {
    bool isCall = (!AppConstants.isFakeMode &&
        _chatController.herId != AppConstants.systemId);
    //debugPrint("call ===> ${isCall}");
    return isCall
        ? InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              AppAudioPlayer().stop();
              _focusNode.unfocus();
              _controller.isShowEmoji.value = false;
              _controller.isShowRecord.value = false;
              ARoutes.toLocalCall(
                  _chatController.herId, _chatController.her?.portrait);
            },
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                  start: 4, top: 4, bottom: 4, end: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xFFE4E4E4)),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsetsDirectional.only(end: 4),
                    child: Image.asset(
                      Assets.iconInputCall,
                      matchTextDirection: true,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  Text(
                    Tr.app_grade_video_chat.tr,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ))
        : const SizedBox.shrink();
  }

  ///表情
  Widget emjio() {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 0, end: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          AppAudioPlayer().stop();
          _focusNode.unfocus();
          if (!_chatController.canSendMsg()) {
            _controller.askVip(anchorId: widget.userId);
            return;
          }
          Future.delayed(const Duration(milliseconds: 100), () {
            _controller.isShowEmoji.value = !_controller.isShowEmoji.value;
            _controller.isShowRecord.value = false;
          });
        },
        child: Container(
          padding: const EdgeInsetsDirectional.all(10),
          child: Image.asset(
            Assets.iconInputEmoji,
            matchTextDirection: true,
            height: 26,
            width: 26,
          ),
        ),
      ),
    );
  }

  ///语音
  Widget voice() {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          AppPermissionHandler.checkAudioPermission().then((value) {
            if (value) {
              AppAudioPlayer().stop();
              _focusNode.unfocus();
              _controller.isShowEmoji.value = false;
              if (!_chatController.canSendMsg()) {
                _controller.askVip(
                  anchorId: widget.userId,
                );
                return;
              }
              _controller.isShowRecord.value = !_controller.isShowRecord.value;
              _controller.isShowEmoji.value = false;
              setState(() {
                isInputEdit = false;
              });
            }
          });
        },
        child: Container(
          padding: const EdgeInsetsDirectional.only(
              start: 10, end: 10, top: 10, bottom: 10),
          child: Image.asset(
            Assets.iconInputAudio,
            matchTextDirection: true,
            width: 26,
            height: 26,
          ),
        ),
      ),
    );
  }

  ///输入
  Widget input() {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          setState(() {
            isInputEdit = true;
          });
        },
        child: Container(
          padding: const EdgeInsetsDirectional.only(
              start: 10, end: 10, top: 10, bottom: 10),
          child: Image.asset(
            Assets.iconInputEdit,
            matchTextDirection: true,
            width: 26,
            height: 26,
          ),
        ),
      ),
    );
  }

  ///显示emoji
  Widget showEmoji() {
    return SizedBox(
      height: keyBordHeight,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          var textEditCtr = _controller.textEditingController;
          textEditCtr
            ..text += emoji.emoji
            ..selection = TextSelection.fromPosition(
                TextPosition(offset: textEditCtr.text.length));
        },
        onBackspacePressed: () {
          var textEditingCtr = _controller.textEditingController;
          textEditingCtr
            ..text = textEditingCtr.text.characters.skipLast(1).toString()
            ..selection = TextSelection.fromPosition(
                TextPosition(offset: textEditingCtr.text.length));
        },
        config: Config(
            columns: 7,
            emojiSizeMax: 32 * (GetPlatform.isIOS ? 1.30 : 1.0),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            initCategory: Category.RECENT,
            bgColor: Colors.white,
            indicatorColor: Colors.black,
            iconColor: Colors.black.withOpacity(0.5),
            iconColorSelected: Colors.black,
            backspaceColor: const Color(0xFFFC0193),
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            recentsLimit: 28,
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL),
      ),
    );
  }

  ///显示voice
  /* Widget showAudio() {
    return AppVoiceBottomWidgetRecord(
      uploadCallBack: _controller.voiceRecord,
      onClose: () {
        _controller.isShowRecord.value = false;
      },
    );
  }
*/
  ///按下说话
  Widget pressToSpeak() {
    return AppVoiceRecord(
      uploadCallBack: _controller.voiceRecord,
      onClose: () {
        _controller.isShowRecord.value = false;
      },
    );
  }
}
