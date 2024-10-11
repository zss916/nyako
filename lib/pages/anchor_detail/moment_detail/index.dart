library moment_detail_page;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_moment_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/anchor_detail/moment_detail/widget/build_call_button.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/widget/app_net_image.dart';
import 'package:oliapro/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
