import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/home/widget/hot/address_select.dart';
import 'package:oliapro/utils/app_extends.dart';

class SelectCountry extends StatefulWidget {
  String? path;

  SelectCountry({Key? key, this.path}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mounted) {}
        setState(() {
          if (mounted) {
            setState(() {
              isShow = !isShow;
            });
          }
          if (isShow == true) {
            showAddressSelect((item) {
              if (mounted) {
                setState(() {
                  if (item != null) {
                    widget.path = item.path;
                  }
                  isShow = !isShow;
                });
              }
            }, path: widget.path);
          }
        });
      },
      child: Container(
        width: 57,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.white10),
        padding: const EdgeInsetsDirectional.only(
            start: 5, end: 5, top: 0, bottom: 0),
        child: Row(
          children: [
            widget.path == null
                ? Image.asset(
                    Assets.imgLocationIcon,
                    width: 22,
                    height: 22,
                    fit: BoxFit.fill,
                    matchTextDirection: true,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child:
                        cachedImage(widget.path ?? "", width: 20, height: 20),
                  ),
            isShow
                ? const Icon(Icons.arrow_drop_up_rounded,
                    size: 25, color: Colors.white)
                : const Icon(Icons.arrow_drop_down_rounded,
                    size: 25, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
