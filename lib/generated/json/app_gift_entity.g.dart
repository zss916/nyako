import 'package:oliapro/entities/app_gift_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

GiftEntity $GiftEntityFromJson(Map<String, dynamic> json) {
  final GiftEntity giftEntity = GiftEntity();
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    giftEntity.createdAt = createdAt;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    giftEntity.updatedAt = updatedAt;
  }
  final int? gid = jsonConvert.convert<int>(json['gid']);
  if (gid != null) {
    giftEntity.gid = gid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    giftEntity.name = name;
  }
  final int? diamonds = jsonConvert.convert<int>(json['diamonds']);
  if (diamonds != null) {
    giftEntity.diamonds = diamonds;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    giftEntity.type = type;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    giftEntity.icon = icon;
  }
  final String? animEffectUrl =
      jsonConvert.convert<String>(json['animEffectUrl']);
  if (animEffectUrl != null) {
    giftEntity.animEffectUrl = animEffectUrl;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    giftEntity.areaCode = areaCode;
  }
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    giftEntity.online = online;
  }
  final int? rankBy = jsonConvert.convert<int>(json['rankBy']);
  if (rankBy != null) {
    giftEntity.rankBy = rankBy;
  }
  final bool? choose = jsonConvert.convert<bool>(json['choose']);
  if (choose != null) {
    giftEntity.choose = choose;
  }
  final int? vipVisible = jsonConvert.convert<int>(json['vipVisible']);
  if (vipVisible != null) {
    giftEntity.vipVisible = vipVisible;
  }
  final int? quantity = jsonConvert.convert<int>(json['quantity']);
  if (quantity != null) {
    giftEntity.quantity = quantity;
  }
  final bool? isPropGift = jsonConvert.convert<bool>(json['isPropGift']);
  if (isPropGift != null) {
    giftEntity.isPropGift = isPropGift;
  }
  final String? sendGiftRecordId =
      jsonConvert.convert<String>(json['sendGiftRecordId']);
  if (sendGiftRecordId != null) {
    giftEntity.sendGiftRecordId = sendGiftRecordId;
  }
  final int? i = jsonConvert.convert<int>(json['i']);
  if (i != null) {
    giftEntity.i = i;
  }
  return giftEntity;
}

Map<String, dynamic> $GiftEntityToJson(GiftEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  data['gid'] = entity.gid;
  data['name'] = entity.name;
  data['diamonds'] = entity.diamonds;
  data['type'] = entity.type;
  data['icon'] = entity.icon;
  data['animEffectUrl'] = entity.animEffectUrl;
  data['areaCode'] = entity.areaCode;
  data['online'] = entity.online;
  data['rankBy'] = entity.rankBy;
  data['choose'] = entity.choose;
  data['vipVisible'] = entity.vipVisible;
  data['quantity'] = entity.quantity;
  data['isPropGift'] = entity.isPropGift;
  data['sendGiftRecordId'] = entity.sendGiftRecordId;
  data['i'] = entity.i;
  return data;
}

extension GiftEntityExtension on GiftEntity {
  GiftEntity copyWith({
    int? createdAt,
    int? updatedAt,
    int? gid,
    String? name,
    int? diamonds,
    int? type,
    String? icon,
    String? animEffectUrl,
    int? areaCode,
    int? online,
    int? rankBy,
    bool? choose,
    int? vipVisible,
    int? quantity,
    bool? isPropGift,
    String? sendGiftRecordId,
    int? i,
  }) {
    return GiftEntity()
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..gid = gid ?? this.gid
      ..name = name ?? this.name
      ..diamonds = diamonds ?? this.diamonds
      ..type = type ?? this.type
      ..icon = icon ?? this.icon
      ..animEffectUrl = animEffectUrl ?? this.animEffectUrl
      ..areaCode = areaCode ?? this.areaCode
      ..online = online ?? this.online
      ..rankBy = rankBy ?? this.rankBy
      ..choose = choose ?? this.choose
      ..vipVisible = vipVisible ?? this.vipVisible
      ..quantity = quantity ?? this.quantity
      ..isPropGift = isPropGift ?? this.isPropGift
      ..sendGiftRecordId = sendGiftRecordId ?? this.sendGiftRecordId
      ..i = i ?? this.i;
  }
}
