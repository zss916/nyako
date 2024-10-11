library remote_page;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtm/rtm.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/end_type_2.dart';
import 'package:oliapro/dialogs/dialog_confirm.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/call/remote/widget/body.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_voice_player.dart';
import 'package:oliapro/utils/music/app_ring_manager.dart';
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
