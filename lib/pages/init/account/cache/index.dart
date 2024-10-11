library account_current_page;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtm/rtm.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/database/entity/app_login_entity.dart';
import 'package:oliapro/entities/app_login_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/init/account/login/widget/login_btn.dart';
import 'package:oliapro/pages/init/login/interface/other_login_utils.dart';
import 'package:oliapro/pages/init/login/widget/login_check.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/cache/login_cache.dart';
import 'package:oliapro/widget/animated_button.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
