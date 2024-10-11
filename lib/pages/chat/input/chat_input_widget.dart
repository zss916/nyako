import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/sheet_gift_list.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/utils/app_permission_handler.dart';
import 'package:oliapro/utils/app_voice_player.dart';
import 'package:oliapro/widget/app_keybord_logic.dart';
import 'package:oliapro/widget/app_voice_bottom_widget_record.dart';
import 'package:oliapro/widget/semantics/label.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

import '../../../common/app_constants.dart';
import '../../../entities/app_gift_entity.dart';
import '../../../utils/image_update/app_choose_image_util.dart';
import '../../../widget/app_click_widget.dart';
import '../../../widget/gift/app_gift_list_view.dart';
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
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(30), topEnd: Radius.circular(30)),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (_focusNode.hasFocus) {
                    _focusNode.unfocus();
                  } else {
                    _focusNode.requestFocus();
                  }
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.only(
                      start: 15, end: 15, top: 3, bottom: 10),
                  padding: const EdgeInsetsDirectional.only(start: 12, end: 12),
                  decoration: const BoxDecoration(
                      color: Color(0xFF2B1A36),
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  height: 54,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 54,
                          alignment: Alignment.center,
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _controller.textEditingController,
                            maxLines: 1,
                            minLines: 1,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                hintText: Tr.app_message_send_input.tr,
                                hintStyle: const TextStyle(
                                    color: Colors.white30,
                                    fontWeight: FontWeight.w400),
                                hintMaxLines: 1,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 5),
                        child: send(_controller),
                      ),
                    ],
                  ),
                ),
              ),
              if (isSystemId)
                const SizedBox(
                  width: 10,
                  height: 10,
                )
              else
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      emjio(),
                      voice(),
                      call(),
                      pic(),
                      gift(),
                    ],
                  ),
                ),
              Obx(() => _controller.isShowEmoji.value
                  ? showEmoji()
                  : const SizedBox.shrink()),
            ],
          ),
        ),
        Obx(() => _controller.isShowRecord.value
            ? showAudio()
            : const SizedBox.shrink()),
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
          Assets.imgChatSend,
          height: 44 + 10,
          width: 36 + 10,
          matchTextDirection: true,
          // fit: BoxFit.contain,
        ),
      );

  ///礼物
  Widget gift() {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
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
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(50),
                gradient: const LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [
                      Color(0xFFFF81CD),
                      Color(0xFFB51A8F),
                    ])),
            alignment: AlignmentDirectional.center,
            child: Image.asset(
              Assets.imgMsgGift,
              matchTextDirection: true,
              height: 27,
              width: 27,
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Color(0xFFC498FE)),
                borderRadius: BorderRadiusDirectional.circular(20),
                gradient: const LinearGradient(colors: [
                  Color(0xFFAC53FB),
                  Color(0xFF7934F0),
                ])),
            child: Text(
              Tr.app_gift_send.tr,
              style: const TextStyle(color: Colors.white, fontSize: 9),
            ),
          )
        ],
      ),
    ).onLabel(label: SemanticsLabel.gift);
  }

  ///图片
  Widget pic() {
    return InkWell(
        borderRadius: BorderRadius.circular(5),
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
        child: Image.asset(
          Assets.imgMsgPic,
          matchTextDirection: true,
          height: 27,
          width: 27,
        )).onLabel(label: SemanticsLabel.picture);
  }

  ///拨打通话
  Widget call() {
    bool isCall = (!AppConstants.isFakeMode &&
        _chatController.herId != AppConstants.systemId);
    //debugPrint("call ===> ${isCall}");
    return isCall
        ? InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              AppAudioPlayer().stop();
              _focusNode.unfocus();
              _controller.isShowEmoji.value = false;
              _controller.isShowRecord.value = false;
              ARoutes.toLocalCall(
                  _chatController.herId, _chatController.her?.portrait);
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0xFFAC53FB),
                    Color(0xFF7934F0),
                  ]),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              width: 58,
              height: 40,
              child: Center(
                child: RepaintBoundary(
                  child: Image.asset(
                    Assets.animaCall,
                    matchTextDirection: true,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ))
        : const SizedBox.shrink();
  }

  ///表情
  Widget emjio() {
    return InkWell(
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
      child: Image.asset(
        Assets.imgEmoji,
        matchTextDirection: true,
        height: 27,
        width: 27,
      ),
    ).onLabel(label: SemanticsLabel.emote);
  }

  ///语音
  Widget voice() {
    return InkWell(
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
          }
        });
      },
      child: Obx(() => Image.asset(
            _controller.isShowRecord.value ? Assets.imgAudioW : Assets.imgAudio,
            matchTextDirection: true,
            width: 27,
            height: 27,
          )),
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
            bgColor: const Color(0xFF1E1226),
            indicatorColor: const Color(0xFF8239FF),
            iconColor: const Color(0x808239FF),
            iconColorSelected: const Color(0xFF8239FF),
            backspaceColor: const Color(0xFF8239FF),
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
  Widget showAudio() {
    return AppVoiceBottomWidgetRecord(
      uploadCallBack: _controller.voiceRecord,
      onClose: () {
        _controller.isShowRecord.value = false;
      },
    );
  }
}
