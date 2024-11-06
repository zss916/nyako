library prop_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_card_entity.dart';
import 'package:nyako/entities/app_info_entity.dart';
import 'package:nyako/entities/app_sign_card_entity.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/main/me/blacklist/utils/state.dart';
import 'package:nyako/pages/main/me/cardlist/widget/body.dart';
import 'package:nyako/pages/main/me/mine/widget/avatar_state.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
