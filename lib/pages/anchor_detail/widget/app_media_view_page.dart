import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/pages/anchor_detail/widget/app_media_view.dart';

class AppFullScreenSliderPage extends StatefulWidget {
  int position;
  List<AppMediaViewBean> beanList = [];
  int? reportType;
  HostDetail? data;
  String? uid;

  AppFullScreenSliderPage.hostMedia(
      {Key? key,
      required List<HostMedia> list,
      required this.position,
      this.reportType,
      this.uid,
      this.data})
      : beanList = list
            .map((item) => AppMediaViewBean(
                (item.mid ?? 0).toString(),
                item.path ?? '',
                item.cover,
                item.type ?? 0,
                item.mid ?? 0,
                true,
                data))
            .toList(),
        super(key: key);

  @override
  State<AppFullScreenSliderPage> createState() =>
      _AppFullScreenSliderPageState();
}

class _AppFullScreenSliderPageState extends State<AppFullScreenSliderPage> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _current = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Builder(
            builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              return CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  initialPage: widget.position,
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: widget.beanList.length > 2,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: widget.beanList.map((item) {
                  return Center(
                      child: AppMediaViewPage(bean: item, uid: widget.uid));
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AppMediaViewBean {
  String? mId;
  String path;
  String? cover;
  int type;
  int heroId;
  bool noAppBar;
  HostDetail? data;

  AppMediaViewBean(this.mId, this.path, this.cover, this.type, this.heroId,
      this.noAppBar, this.data);
}
