library aiv_page;

import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/end_type.dart';
import 'package:nyako/dialogs/sheet_gift_list.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/call/aiv/widget/connecting/connecting.dart';
import 'package:nyako/pages/call/aiv/widget/page/aiv_body.dart';
import 'package:nyako/pages/call/aiv/widget/warn_tip.dart';
import 'package:nyako/pages/main/match/util/bgm_control.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/observer/route_extend.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/gift/gift_utils.dart';
import 'package:nyako/widget/gift/app_vap_player.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../common/charge_path.dart';
import '../../../entities/app_aiv_entity.dart';
import '../../../entities/app_contribute_entity.dart';
import '../../../entities/app_gift_entity.dart';
import '../../../entities/app_host_entity.dart';
import '../../../entities/app_info_entity.dart';
import '../../../utils/app_loading.dart';
import '../../../widget/gift/app_gift_data_helper.dart';
import '../../../widget/gift/app_gift_list_view.dart';
import '../../charge/charge_dialog_manager.dart';
import 'widget/aiv_video_controller.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
