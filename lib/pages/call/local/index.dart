library local_page;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtm/rtm.dart';
import 'package:oliapro/agora/rtm_msg_sender.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/app_style.dart';
import 'package:oliapro/common/call_status.dart';
import 'package:oliapro/common/end_type_2.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_confirm_hang.dart';
import 'package:oliapro/dialogs/dialog_rtm_confirm.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/call/local/widget/body.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/music/app_ring_manager.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/charge_path.dart';
import '../../../entities/app_host_entity.dart';
import '../../../services/storage_service.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
