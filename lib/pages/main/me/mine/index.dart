library mine_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_common_dialog.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_bind_google.dart';
import 'package:oliapro/dialogs/dialog_confirm.dart';
import 'package:oliapro/dialogs/dialog_free_diamond.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/dialogs/sheet_search.dart';
import 'package:oliapro/dialogs/sheet_service.dart';
import 'package:oliapro/dialogs/sign/dialog_sign.dart';
import 'package:oliapro/entities/app_info_entity.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/main/me/mine/widget/body.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/socket/app_socket_manager.dart';
import 'package:oliapro/socket/socket_entity.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/app_some_extension.dart';

part 'logic.dart';
part 'state.dart';
part 'view.dart';
