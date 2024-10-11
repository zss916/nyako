import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/pages/main/home/index.dart';
import 'package:oliapro/pages/main/home/widget/hot/select_country.dart';

class BuildSelectCountry extends StatelessWidget {
  const BuildSelectCountry({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
        init: HomeLogic(),
        id: "currentAreaId",
        builder: (logic) => SelectCountry(path: logic.currentArea?.path));
  }
}
