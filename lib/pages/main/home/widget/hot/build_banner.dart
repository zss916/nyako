import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:nyako/pages/main/home/index.dart';

class BuildBanner extends StatelessWidget {
  final HomeLogic logic;

  const BuildBanner(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      height: 110,
      width: double.maxFinite,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => logic.banners[index].clickBanner(),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.white12,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                        logic.banners[index].cover ?? "",
                      )),
                  borderRadius: BorderRadiusDirectional.circular(20)),
              margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            ),
          );
        },
        itemCount: logic.banners.length,
        autoplay: true,
        autoplayDelay: 4500,
        duration: 1200,
      ),
    );
  }
}
