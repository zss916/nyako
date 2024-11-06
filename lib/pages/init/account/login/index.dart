library account_login_page;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/agora/rtm/rtm.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/pages/init/account/login/widget/body.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/cache/login_cache.dart';

import '../../../../common/app_constants.dart';
import '../../../../common/language_key.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_loading.dart';
import '../../../../widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
