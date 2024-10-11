import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class AESUtils {
  ///aes 解密
  static String decode({required String appChannel, required String data}) {
    String formatData = "0123456789ABCDEF";
    String str =
        base64.encode(utf8.encode("$appChannel$formatData")).substring(0, 16);
    final key = Key.fromUtf8(str);
    final iv = IV.fromUtf8(str);
    return Encrypter(AES(key, mode: AESMode.cbc))
        .decrypt(Encrypted.fromBase64(data), iv: iv);
  }
}
