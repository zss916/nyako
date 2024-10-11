library aiv_page;

import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/end_type.dart';
import 'package:oliapro/dialogs/sheet_gift_list.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/call/aiv/widget/connecting/connecting.dart';
import 'package:oliapro/pages/call/aiv/widget/page/aiv_body.dart';
import 'package:oliapro/pages/call/aiv/widget/warn_tip.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/observer/route_extend.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/gift/gift_utils.dart';
import 'package:oliapro/widget/gift/app_vap_player.dart';
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
