library http;

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dio_response;
import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';
import 'package:nyako/http/adapter/httpClientAdapter.dart';
import 'package:nyako/http/config/base/base_response.dart';
import 'package:nyako/http/config/base/error_entity.dart';
import 'package:nyako/http/config/dio_options.dart';
import 'package:nyako/http/config/query_data.dart';
import 'package:nyako/http/interceptor/data_interceptor.dart';
import 'package:nyako/http/interceptor/logger_interceptor.dart';
import 'package:nyako/http/interceptor/net_interceptor.dart';
import 'package:nyako/http/interceptor/path_interceptor.dart';
import 'package:nyako/http/util/special_path_utils.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_loading.dart';

part 'net.dart';
part 'net_path.dart';
