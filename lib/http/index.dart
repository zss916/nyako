library http;

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dio_response;
import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';
import 'package:oliapro/http/adapter/httpClientAdapter.dart';
import 'package:oliapro/http/config/base/base_response.dart';
import 'package:oliapro/http/config/base/error_entity.dart';
import 'package:oliapro/http/config/dio_options.dart';
import 'package:oliapro/http/config/query_data.dart';
import 'package:oliapro/http/interceptor/data_interceptor.dart';
import 'package:oliapro/http/interceptor/logger_interceptor.dart';
import 'package:oliapro/http/interceptor/net_interceptor.dart';
import 'package:oliapro/http/interceptor/path_interceptor.dart';
import 'package:oliapro/http/util/special_path_utils.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_loading.dart';

part 'net.dart';
part 'net_path.dart';
