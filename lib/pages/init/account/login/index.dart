library account_login_page;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtm/rtm.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/init/account/login/widget/body.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/cache/login_cache.dart';

import '../../../../common/app_constants.dart';
import '../../../../common/language_key.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_loading.dart';
import '../../../../widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
