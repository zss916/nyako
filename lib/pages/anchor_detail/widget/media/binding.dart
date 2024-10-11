part of media_page;

class MediasBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediasLogic>(() => MediasLogic());
  }
}
