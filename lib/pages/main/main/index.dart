library main_page;

import 'dart:async';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:oliapro/agora/rtm/rtm.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/dialogs/dialog_change_psd2.dart';
import 'package:oliapro/dialogs/dialog_new_user.dart';
import 'package:oliapro/dialogs/reward_dialog/pdd_util.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/charge/billing.dart';
import 'package:oliapro/pages/main/discover/index.dart';
import 'package:oliapro/pages/main/home/index.dart';
import 'package:oliapro/pages/main/main/widget/build_double_back.dart';
import 'package:oliapro/pages/main/main/widget/build_show_vip_online.dart';
import 'package:oliapro/pages/main/match/index.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/pages/main/me/calllist/index.dart';
import 'package:oliapro/pages/main/me/mine/index.dart';
import 'package:oliapro/pages/main/msg/index.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/socket/app_socket_manager.dart';
import 'package:oliapro/utils/adjust/app_adjust.dart';
import 'package:oliapro/utils/ai/ai_logic_utils.dart';
import 'package:oliapro/utils/app_check_app_update.dart';
import 'package:oliapro/utils/app_check_dnd.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_permission_handler.dart';
import 'package:oliapro/utils/cache/login_cache.dart';

import '../../../dialogs/dialog_warm_tip.dart';
import '../../../routes/app_pages.dart';
import '../../../services/event_bus_bean.dart';
import '../../../utils/app_pay_cache_manager.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
