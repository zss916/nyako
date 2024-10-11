library public_page;

import 'package:flutter/material.dart';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_top_confirm.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/main/public/widget/body.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/image_update/app_choose_image_util.dart';
import 'package:oliapro/widget/base_app_bar.dart';
import 'package:oliapro/widget/semantics/label.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

part 'binding.dart';
part 'logic.dart';
part 'view.dart';
