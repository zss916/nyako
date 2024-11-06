library account_current_page;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/agora/rtm/rtm.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/database/entity/app_login_entity.dart';
import 'package:nyako/entities/app_login_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/init/account/login/widget/login_btn.dart';
import 'package:nyako/pages/init/login/interface/other_login_utils.dart';
import 'package:nyako/pages/init/login/widget/login_check.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/utils/cache/login_cache.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
