import 'dart:convert';

/// transferAppIcon : ""
/// transferAppName : ""
/// transferAppPackageName : ""

TransferInfo transferInfoFromJson(String str) =>
    TransferInfo.fromJson(json.decode(str));
String transferInfoToJson(TransferInfo data) => json.encode(data.toJson());

class TransferInfo {
  TransferInfo({
    String? transferAppIcon,
    String? transferAppName,
    String? transferAppPackageName,
  }) {
    _transferAppIcon = transferAppIcon;
    _transferAppName = transferAppName;
    _transferAppPackageName = transferAppPackageName;
  }

  TransferInfo.fromJson(dynamic json) {
    _transferAppIcon = json['transferAppIcon'];
    _transferAppName = json['transferAppName'];
    _transferAppPackageName = json['transferAppPackageName'];
  }
  String? _transferAppIcon;
  String? _transferAppName;
  String? _transferAppPackageName;
  TransferInfo copyWith({
    String? transferAppIcon,
    String? transferAppName,
    String? transferAppPackageName,
  }) =>
      TransferInfo(
        transferAppIcon: transferAppIcon ?? _transferAppIcon,
        transferAppName: transferAppName ?? _transferAppName,
        transferAppPackageName:
            transferAppPackageName ?? _transferAppPackageName,
      );
  String? get transferAppIcon => _transferAppIcon;
  String? get transferAppName => _transferAppName;
  String? get transferAppPackageName => _transferAppPackageName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transferAppIcon'] = _transferAppIcon;
    map['transferAppName'] = _transferAppName;
    map['transferAppPackageName'] = _transferAppPackageName;
    return map;
  }
}
