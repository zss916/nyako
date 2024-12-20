library settlement_page;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/agora/rtm_msg_sender.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/call_status.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/database/entity/app_her_entity.dart';
import 'package:nyako/dialogs/sheet_report.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/call/end/widget/build_chat_button.dart';
import 'package:nyako/pages/charge/charge_dialog_manager.dart';
import 'package:nyako/pages/main/home/widget/hot/hot_chat_button.dart';
import 'package:nyako/pages/main/match/util/bgm_control.dart';
import 'package:nyako/pages/widget/base_empty.dart';
import 'package:nyako/pages/widget/line_state.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_format_util.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/utils/app_permission_handler.dart';
import 'package:nyako/widget/app_ball_beat.dart';

import '../../../entities/app_end_call_entity.dart';
import '../../../entities/app_host_entity.dart';
import '../../../services/event_bus_bean.dart';
import '../../../utils/app_event_bus.dart';
import '../../../widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
