library edit_info_page;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/edit_birth_dialog.dart';
import 'package:oliapro/dialogs/sheet_edit_intro.dart';
import 'package:oliapro/dialogs/sheet_edit_name.dart';
import 'package:oliapro/dialogs/sheet_select_gender.dart';
import 'package:oliapro/entities/app_info_entity.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/main/me/info/widget/body.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/cache/login_cache.dart';
import 'package:oliapro/utils/image_update/app_choose_image_util.dart';
import 'package:oliapro/widget/base_app_bar.dart';

import '../../../../utils/app_loading.dart';

part 'binding.dart';
part 'logic.dart';
part 'state.dart';
part 'view.dart';
