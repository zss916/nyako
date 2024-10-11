import 'dart:convert';
import 'dart:io';

class ZipUtil {
  /// 压缩字符串
  static String zipStr(String str) =>
      base64Encode(zlib.encode(utf8.encode(str)));

  /// 解压字符串
  static String unZipStr(String str) =>
      utf8.decode(zlib.decode(base64Decode(str)));
}
