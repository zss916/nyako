library home_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/database/entity/app_her_entity.dart';
import 'package:oliapro/entities/app_banner_entity.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/main/home/service.dart';
import 'package:oliapro/pages/main/home/widget/hot_body2.dart';
import 'package:oliapro/pages/main/me/blacklist/utils/state.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/socket/socket_entity.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/app_permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'logic.dart';
part 'view.dart';
