library anchor_detail_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/database/entity/app_her_entity.dart';
import 'package:oliapro/dialogs/dialog_confirm.dart';
import 'package:oliapro/dialogs/reward_dialog/pdd_util.dart';
import 'package:oliapro/entities/app_contribute_entity.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/entities/app_moment_entity.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/body.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/app_permission_handler.dart';
import 'package:oliapro/utils/app_some_extension.dart';
import 'package:oliapro/widget/gift/app_vap_player.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main/me/calllist/service.dart';

part 'binding.dart';
part 'logic.dart';
part 'state.dart';
part 'view.dart';
