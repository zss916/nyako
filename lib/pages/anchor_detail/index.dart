library anchor_detail_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/database/entity/app_her_entity.dart';
import 'package:nyako/dialogs/dialog_confirm.dart';
import 'package:nyako/dialogs/reward_dialog/pdd_util.dart';
import 'package:nyako/entities/app_contribute_entity.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/entities/app_moment_entity.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/anchor_detail/widget/body.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/utils/app_permission_handler.dart';
import 'package:nyako/utils/app_some_extension.dart';
import 'package:nyako/widget/gift/app_vap_player.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main/me/calllist/service.dart';

part 'binding.dart';
part 'logic.dart';
part 'state.dart';
part 'view.dart';
