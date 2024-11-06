library recharge_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:nyako/entities/app_charge_quick_entity.dart';
import 'package:nyako/entities/app_draw_user_entity.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/charge/billing.dart';
import 'package:nyako/pages/charge/charge_dialog_manager.dart';
import 'package:nyako/pages/main/me/recharge/widget/body.dart';
import 'package:nyako/pages/main/me/recharge/widget/build_action.dart';
import 'package:nyako/pages/main/me/recharge/widget/draw.dart';
import 'package:nyako/pages/main/me/recharge/widget/popscope_widget.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/utils/cache/product_cache.dart';
import 'package:nyako/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
