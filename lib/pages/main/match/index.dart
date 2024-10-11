library match_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/entities/app_host_match_limit_entity.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/main/match/result/match_dialog.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/pages/main/match/widget/body.dart';
import 'package:oliapro/pages/main/match/widget/music_bgm.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
