library contribute_list_page;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_contribute_entity.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/anchor_detail/contribute_list/widget/build_contributions.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
