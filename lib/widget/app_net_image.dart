import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

/// 网络加载图片
class AppNetImage extends CachedNetworkImage {
  AppNetImage(
    String imageUrl, {
    super.key,
    String? placeholderAsset,
    ImageWidgetBuilder? imageBuilder,
    PlaceholderWidgetBuilder? placeholder,
    LoadingErrorWidgetBuilder? errorWidget,
    BoxFit? fit,
    super.width,
    super.height,
    //圆角
    double? radius,
    // 圆形
    bool isCircle = false,
    bool showBorder = false,
    Color borderColor = Colors.white,
    double borderWidth = 1,
  }) : super(
            imageUrl: imageUrl,
            imageBuilder: imageBuilder ??
                (context, imageProvider) => isCircle
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  showBorder ? borderColor : Colors.transparent,
                              width: showBorder ? borderWidth : 0.0),
                          image: DecorationImage(
                              image: imageProvider, fit: fit ?? BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      )
                    : Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  showBorder ? borderColor : Colors.transparent,
                              width: showBorder ? borderWidth : 0.0),
                          image: DecorationImage(
                              image: imageProvider, fit: fit ?? BoxFit.cover),
                          borderRadius: BorderRadius.circular(radius ?? 0),
                        ),
                      ),
            placeholder: placeholder ??
                (context, url) {
                  return isCircle
                      ? Container(
                          clipBehavior: Clip.hardEdge,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(
                            (placeholderAsset != null &&
                                    placeholderAsset.isNotEmpty)
                                ? placeholderAsset
                                : Assets.imgAppLogo,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius ?? 0),
                          ),
                          child: Image.asset(
                            (placeholderAsset != null &&
                                    placeholderAsset.isNotEmpty)
                                ? placeholderAsset
                                : Assets.imgAppLogo,
                            fit: BoxFit.fill,
                          ),
                        );
                },
            errorWidget: errorWidget ??
                (context, url, error) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius ?? 0),
                    ),
                    child: Image.asset(
                      (placeholderAsset != null && placeholderAsset.isNotEmpty)
                          ? placeholderAsset
                          : Assets.imgAppLogo,
                      fit: BoxFit.fill,
                    ),
                  );
                },
            fit: fit ?? BoxFit.cover);
}
