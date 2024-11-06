import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:nyako/services/user_info.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';

class EncryptUtils {
  // Rsa加密最大长度(密钥长度/8-11)
  static const int MAX_ENCRYPT_BLOCK = 245;

  // Rsa解密最大长度(密钥长度/8)
  static const int MAX_DECRYPT_BLOCK = 256;

  /// 加密
  static dynamic encodeData(String content, {AESMode aesMode = AESMode.ecb}) {
    var key = UserInfo.to.config?.publicKey ?? "";
    if (key.isEmpty) {
      return content;
    }
    final aesKey = '-----BEGIN PUBLIC KEY-----\n$key\n-----END PUBLIC KEY-----';
    var aesPublicKey = RSAKeyParser().parse(aesKey) as RSAPublicKey;
    final encrypt = Encrypter(RSA(publicKey: aesPublicKey));

    List<int> sourceBytes = utf8.encode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 117;
    //int maxLen = MAX_ENCRYPT_BLOCK;
    List<int> totalBytes = [];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      List<int> item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypt.encryptBytes(item).bytes);
    }
    return base64.encode(totalBytes);
  }

  ///解密(私钥存在服务器)
  static String decodeData(String content) {
    var publicPem = ""; //私钥
    //创建公钥对象
    RSAPublicKey publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;

    AsymmetricBlockCipher cipher = PKCS1Encoding(RSAEngine());
    cipher.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));

    //分段解密
    //原始数据
    List<int> sourceBytes = base64Decode(content);
    //数据长度
    int inputLength = sourceBytes.length;
    // 缓存数组
    List<int> cache = [];
    // 分段解密 步长为MAX_DECRYPT_BLOCK
    for (var i = 0; i < inputLength; i += MAX_DECRYPT_BLOCK) {
      //剩余长度
      int endLen = inputLength - i;
      List<int> item;
      if (endLen > MAX_DECRYPT_BLOCK) {
        item = sourceBytes.sublist(i, i + MAX_DECRYPT_BLOCK);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      //解密后放到数组缓存
      cache.addAll(cipher.process(Uint8List.fromList(item)));
    }
    return utf8.decode(cache);
  }
}
