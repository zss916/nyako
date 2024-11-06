library mine_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_common_dialog.dart';
import 'package:nyako/common/app_common_type.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/dialog_bind_google.dart';
import 'package:nyako/dialogs/dialog_confirm.dart';
import 'package:nyako/dialogs/dialog_free_diamond.dart';
import 'package:nyako/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:nyako/dialogs/sheet_search.dart';
import 'package:nyako/dialogs/sheet_service.dart';
import 'package:nyako/dialogs/sign/dialog_sign.dart';
import 'package:nyako/entities/app_info_entity.dart';
import 'package:nyako/game/game_dialog_manager.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/main/me/mine/widget/body.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/socket/app_socket_manager.dart';
import 'package:nyako/socket/socket_entity.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/utils/app_some_extension.dart';

part 'logic.dart';
part 'state.dart';
part 'view.dart';
