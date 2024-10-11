library recharge_page;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/entities/app_draw_user_entity.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/entities/app_recharge_active_config_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/charge/billing.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';
import 'package:oliapro/pages/main/me/recharge/widget/body.dart';
import 'package:oliapro/pages/main/me/recharge/widget/build_action.dart';
import 'package:oliapro/pages/main/me/recharge/widget/draw.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/cache/product_cache.dart';
import 'package:oliapro/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
