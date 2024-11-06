library reward;

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_balance_list_entity.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/main/me/reward_details/widget/body.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/widget/base_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../calllist/service.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
