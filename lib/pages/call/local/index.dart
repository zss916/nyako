library local_page;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/agora/rtm/rtm.dart';
import 'package:nyako/agora/rtm_msg_sender.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/app_style.dart';
import 'package:nyako/common/call_status.dart';
import 'package:nyako/common/end_type_2.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/dialog_confirm_hang.dart';
import 'package:nyako/dialogs/dialog_rtm_confirm.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/call/local/widget/body.dart';
import 'package:nyako/pages/charge/charge_dialog_manager.dart';
import 'package:nyako/pages/main/match/util/bgm_control.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/utils/music/app_ring_manager.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/charge_path.dart';
import '../../../entities/app_host_entity.dart';
import '../../../services/storage_service.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
