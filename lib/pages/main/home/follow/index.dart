library follow_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/database/entity/app_her_entity.dart';
import 'package:nyako/entities/app_banner_entity.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/main/home/follow/service.dart';
import 'package:nyako/pages/main/home/follow/widget/follow.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/socket/socket_entity.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/utils/app_permission_handler.dart';
import 'package:nyako/widget/base_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
