library contribute_list_page;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_contribute_entity.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/anchor_detail/contribute_list/widget/build_contributions.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
