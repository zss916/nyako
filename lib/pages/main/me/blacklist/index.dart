library black_list_page;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/dialog_confirm.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/pages/main/me/blacklist/utils/state.dart';
import 'package:nyako/pages/main/me/blacklist/widget/body.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/widget/base_app_bar.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
