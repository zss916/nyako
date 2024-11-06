library edit_info_page;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/edit_birth_dialog.dart';
import 'package:nyako/dialogs/sheet_edit_intro.dart';
import 'package:nyako/dialogs/sheet_edit_name.dart';
import 'package:nyako/dialogs/sheet_select_gender.dart';
import 'package:nyako/entities/app_info_entity.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/pages/main/me/info/widget/body.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/cache/login_cache.dart';
import 'package:nyako/utils/image_update/app_choose_image_util.dart';
import 'package:nyako/widget/base_app_bar.dart';

import '../../../../utils/app_loading.dart';

part 'binding.dart';
part 'logic.dart';
part 'state.dart';
part 'view.dart';
