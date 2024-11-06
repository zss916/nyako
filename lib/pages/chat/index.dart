library chat_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/agora/rtm_msg_entity.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/database/entity/app_her_entity.dart';
import 'package:nyako/database/entity/app_msg_entity.dart';
import 'package:nyako/dialogs/sheet_gift_list.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/entities/app_info_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/pages/chat/input/chat_input_controller.dart';
import 'package:nyako/pages/chat/input/chat_input_widget.dart';
import 'package:nyako/pages/chat/msgitem/chat_msg_image.dart';
import 'package:nyako/pages/chat/msgitem/chat_msg_voice.dart';
import 'package:nyako/pages/chat/widget/build_chat_more.dart';
import 'package:nyako/pages/chat/widget/build_chat_portrait.dart';
import 'package:nyako/pages/chat/widget/build_chat_report.dart';
import 'package:nyako/pages/chat/widget/build_msg_card.dart';
import 'package:nyako/pages/chat/widget/build_recharge_tip.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_log.dart';
import 'package:nyako/utils/gift/gift_utils.dart';
import 'package:nyako/utils/translate/app_translate_util.dart';
import 'package:nyako/widget/gift/app_gift_list_view.dart';
import 'package:nyako/widget/gift/app_vap_player.dart';
import 'package:nyako/widget/semantics/label.dart';
import 'package:nyako/widget/semantics/semantics_widget.dart';

import '../../entities/app_gift_entity.dart';
import '../../services/event_bus_bean.dart';
import '../../services/storage_service.dart';
import '../../utils/app_gift_follow_tip.dart';
import '../../utils/app_loading.dart';
import '../../utils/app_voice_player.dart';
import 'msgitem/chat_msg_call.dart';
import 'msgitem/chat_msg_gift.dart';
import 'msgitem/chat_msg_text.dart';
import 'msgitem/chat_msg_wrapper.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
