library lottery_page;

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_draw_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/charge/charge_dialog_manager.dart';
import 'package:nyako/pages/main/me/lottery/widget/body.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
