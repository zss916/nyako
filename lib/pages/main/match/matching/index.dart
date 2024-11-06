library matching_page;

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_host_match_limit_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/match/index.dart';
import 'package:nyako/pages/main/match/matching/widget/rotation_widget.dart';
import 'package:nyako/pages/main/match/result/match_dialog.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
