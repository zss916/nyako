library login_page;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtm/rtm.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/app_style.dart';
import 'package:oliapro/entities/app_login_entity.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/init/login/interface/other_login_utils.dart';
import 'package:oliapro/pages/init/login/widget/body.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/services/app_info_service.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_check_app_update.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/cache/login_cache.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
