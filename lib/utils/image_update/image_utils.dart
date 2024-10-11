import 'dart:io';
import 'dart:math';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  ///选择单张图片
  static Future<XFile?> chooseOneImage({bool camera = true}) {
    return ImagePicker().pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080);
  }

  ///选择多张图片
  static void chooseMultiImage() {
    ImagePicker().pickMultiImage().then((value) {});
  }

  /// 图片压缩
  static Future<String> compress(String path) {
    return compressImageAndGetFile(File(path));
  }

  static Future<String> compressImageAndGetFile(File file) async {
    var path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1);
    var targetPath = await _createTempFile(name: name, dir: 'pic');
    CompressFormat format = CompressFormat.jpeg;
    if (name.endsWith(".jpg") || name.endsWith(".jpeg")) {
      format = CompressFormat.jpeg;
    } else if (name.endsWith(".png")) {
      format = CompressFormat.png;
    } else if (name.endsWith(".heic")) {
      format = CompressFormat.heic;
    } else if (name.endsWith(".webp")) {
      format = CompressFormat.webp;
    }

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 90,
      minWidth: 480,
      minHeight: 800,
      format: format,
    );
    return result?.path ?? "";
  }

  static Future<String> _createTempFile({
    required String dir,
    required String name,
  }) async {
    final storage = (Platform.isIOS
        ? await getTemporaryDirectory()
        : await getExternalStorageDirectory());
    Directory directory = Directory('${storage!.path}/$dir');
    if (!(await directory.exists())) {
      directory.create(recursive: true);
    }
    File file = File('${directory.path}/$name');
    if (!(await file.exists())) {
      file.create();
    }
    return file.path;
  }

  static String _getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  static String getShowLogger(String path) =>
      "path:${path}, size: ${_getFileSizeString(bytes: File(path).lengthSync())}}";
}
