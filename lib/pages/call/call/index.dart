library call_page;

import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtc/index.dart';
//import 'package:oliapro/agora/rtc5.2.0/index.dart';
import 'package:oliapro/agora/rtm/rtm.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/common/call_status.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/end_type_2.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_call_sexy.dart';
import 'package:oliapro/dialogs/dialog_confirm.dart';
import 'package:oliapro/dialogs/sheet_gift_list.dart';
import 'package:oliapro/entities/app_contribute_entity.dart';
import 'package:oliapro/entities/app_gift_entity.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/entities/app_info_entity.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/call/call/widget/call_follow_tip.dart';
import 'package:oliapro/pages/call/call/widget/connecting/connecting.dart';
import 'package:oliapro/pages/call/call/widget/net_cancel.dart';
import 'package:oliapro/pages/call/call/widget/page/video_page.dart';
import 'package:oliapro/pages/call/call/widget/warn_tip.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/observer/route_extend.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart' as AppUserInfo;
import 'package:oliapro/socket/app_socket_manager.dart';
import 'package:oliapro/socket/socket_entity.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/gift/gift_utils.dart';
import 'package:oliapro/widget/gift/app_gift_data_helper.dart';
import 'package:oliapro/widget/gift/app_gift_list_view.dart';
import 'package:oliapro/widget/gift/app_vap_player.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../routes/app_pages.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';