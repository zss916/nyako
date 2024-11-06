library main_page;

import 'dart:async';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:nyako/agora/rtm/rtm.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/dialogs/dialog_change_psd2.dart';
import 'package:nyako/dialogs/dialog_new_user.dart';
import 'package:nyako/dialogs/reward_dialog/pdd_util.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/pages/charge/billing.dart';
import 'package:nyako/pages/main/discover/index.dart';
import 'package:nyako/pages/main/home/index.dart';
import 'package:nyako/pages/main/main/widget/build_double_back.dart';
import 'package:nyako/pages/main/main/widget/build_show_vip_online.dart';
import 'package:nyako/pages/main/match/index.dart';
import 'package:nyako/pages/main/match/util/bgm_control.dart';
import 'package:nyako/pages/main/me/calllist/index.dart';
import 'package:nyako/pages/main/me/mine/index.dart';
import 'package:nyako/pages/main/msg/index.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/socket/app_socket_manager.dart';
import 'package:nyako/utils/adjust/app_adjust.dart';
import 'package:nyako/utils/ai/ai_logic_utils.dart';
import 'package:nyako/utils/app_check_app_update.dart';
import 'package:nyako/utils/app_check_dnd.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_permission_handler.dart';
import 'package:nyako/utils/cache/login_cache.dart';

import '../../../dialogs/dialog_warm_tip.dart';
import '../../../routes/app_pages.dart';
import '../../../services/event_bus_bean.dart';
import '../../../utils/app_pay_cache_manager.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
