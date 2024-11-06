library match_page;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/entities/app_host_match_limit_entity.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/main/match/result/match_dialog.dart';
import 'package:nyako/pages/main/match/util/bgm_control.dart';
import 'package:nyako/pages/main/match/widget/body.dart';
import 'package:nyako/pages/main/match/widget/music_bgm.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
