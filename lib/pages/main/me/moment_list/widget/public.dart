import 'package:flutter/material.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildPublic extends StatelessWidget {
  const BuildPublic({super.key});

  @override
  Widget build(BuildContext context) {
    return public();
  }

  Widget public() {
    return UnconstrainedBox(
        child: GestureDetector(
            onTap: () => ARoutes.toPublicDynamic(),
            child: Container(
              width: 47,
              height: 28,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      stops: [
                        0,
                        0.98
                      ],
                      colors: [
                        Color(0xFFFFF3F9),
                        Color(0xFFFFF3F9),
                      ]),
                  borderRadius: BorderRadiusDirectional.circular(50)),
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(
                    "Assets.imgPublic",
                    width: 18,
                    height: 17,
                    matchTextDirection: true,
                  )
                ],
              ),
            )));
  }
}
