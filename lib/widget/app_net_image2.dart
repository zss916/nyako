import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 网络加载图片
class AppNetImage2 extends CachedNetworkImage {
  AppNetImage2(
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
                (context, imageProvider) => Container(
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
                  return (placeholderAsset != null &&
                          placeholderAsset.isNotEmpty)
                      ? Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius ?? 0),
                          ),
                          child: Image.asset(
                            placeholderAsset,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          clipBehavior: Clip.hardEdge,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(radius ?? 0),
                          ),
                          child: const CircularProgressIndicator(
                            color: Color(0xFF7A35F0),
                          ),
                        );
                },
            errorWidget: errorWidget ??
                (context, url, error) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(radius ?? 0),
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 35,
                    ),
                  );
                },
            fit: fit ?? BoxFit.cover);
}
