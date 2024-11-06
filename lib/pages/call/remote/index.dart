library remote_page;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/agora/rtm/rtm.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/app_style.dart';
import 'package:nyako/common/end_type_2.dart';
import 'package:nyako/dialogs/dialog_confirm.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/call/remote/widget/body.dart';
import 'package:nyako/pages/charge/charge_dialog_manager.dart';
import 'package:nyako/pages/main/match/util/bgm_control.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_voice_player.dart';
import 'package:nyako/utils/music/app_ring_manager.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../common/call_status.dart';
import '../../../common/charge_path.dart';
import '../../../common/language_key.dart';
import '../../../database/entity/app_aic_entity.dart';
import '../../../database/entity/app_her_entity.dart';
import '../../../entities/app_aiv_entity.dart';
import '../../../entities/app_host_entity.dart';
import '../../../services/event_bus_bean.dart';
import '../../../services/storage_service.dart';
import '../../../utils/ai/ai_logic_utils.dart';
import '../../../utils/app_check_calling_util.dart';
import '../../../utils/app_loading.dart';
import '../../../utils/app_permission_handler.dart';

part 'binding.dart';
part 'logic.dart';
part 'state.dart';
part 'view.dart';
