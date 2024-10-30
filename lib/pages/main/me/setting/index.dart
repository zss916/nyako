library setting_page;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_common_dialog.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_confirm.dart';
import 'package:oliapro/dialogs/dialog_new_user.dart';
import 'package:oliapro/dialogs/sheet_search.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/main/me/setting/widget/body.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
