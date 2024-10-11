import 'dart:convert';

/// pageNum : 0
/// pageSize : 0
/// size : 0
/// pages : 0
/// total : 18
/// hasNext : false

PageEntity pageEntityFromJson(String str) =>
    PageEntity.fromJson(json.decode(str));
String pageEntityToJson(PageEntity data) => json.encode(data.toJson());

class PageEntity {
  PageEntity({
    num? pageNum,
    num? pageSize,
    num? size,
    num? pages,
    num? total,
    bool? hasNext,
  }) {
    _pageNum = pageNum;
    _pageSize = pageSize;
    _size = size;
    _pages = pages;
    _total = total;
    _hasNext = hasNext;
  }

  PageEntity.fromJson(dynamic json) {
    _pageNum = json['pageNum'];
    _pageSize = json['pageSize'];
    _size = json['size'];
    _pages = json['pages'];
    _total = json['total'];
    _hasNext = json['hasNext'];
  }
  num? _pageNum;
  num? _pageSize;
  num? _size;
  num? _pages;
  num? _total;
  bool? _hasNext;
  PageEntity copyWith({
    num? pageNum,
    num? pageSize,
    num? size,
    num? pages,
    num? total,
    bool? hasNext,
  }) =>
      PageEntity(
        pageNum: pageNum ?? _pageNum,
        pageSize: pageSize ?? _pageSize,
        size: size ?? _size,
        pages: pages ?? _pages,
        total: total ?? _total,
        hasNext: hasNext ?? _hasNext,
      );
  num? get pageNum => _pageNum;
  num? get pageSize => _pageSize;
  num? get size => _size;
  num? get pages => _pages;
  num? get total => _total;
  bool? get hasNext => _hasNext;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pageNum'] = _pageNum;
    map['pageSize'] = _pageSize;
    map['size'] = _size;
    map['pages'] = _pages;
    map['total'] = _total;
    map['hasNext'] = _hasNext;
    return map;
  }
}
