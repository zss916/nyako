library record_page;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_call_record_entity.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/main/me/calllist/service.dart';
import 'package:oliapro/pages/main/me/calllist/widget/body.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/app_permission_handler.dart';
import 'package:oliapro/widget/base_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
