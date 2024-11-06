import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/routes/app_pages.dart';

void showGoogleRate() {
  if (!Get.currentRoute.startsWith(AppPages.googleRateSheet)) {
    Get.bottomSheet(const AppGoogleRate(),
        settings: const RouteSettings(name: AppPages.googleRateSheet));
  }
}

class AppGoogleRate extends StatefulWidget {
  const AppGoogleRate({Key? key}) : super(key: key);

  @override
  State<AppGoogleRate> createState() => _AppGoogleRateState();
}

class _AppGoogleRateState extends State<AppGoogleRate> {
  final TextEditingController _textEditingController = TextEditingController();

  int _step = 0;
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _step == 2
          ? Container(
              height: 300,
              padding: const EdgeInsetsDirectional.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Tr.app_google_rate_thank.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Image.asset(
                    Assets.finalGooglePlayRate,
                    matchTextDirection: true,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Tr.app_base_confirm.tr,
                        style: const TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.finalGooglePlay,
                        matchTextDirection: true,
                        width: 26,
                        height: 26,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Google play',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                if (_step == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                Assets.iconSmallLogo,
                                matchTextDirection: true,
                                width: 60,
                                height: 60,
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  AppConstants.appName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  Tr.app_google_rate_tip.tr,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: RatingBar(
                            initialRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Colors.deepPurple,
                              ),
                              half: const Icon(
                                Icons.star,
                                color: Colors.deepPurple,
                              ),
                              empty: const Icon(
                                Icons.star_border_sharp,
                                color: Colors.deepPurple,
                              ),
                            ),
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                                _step = 1;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                if (_step == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.iconSmallLogo,
                              matchTextDirection: true,
                              width: 60,
                              height: 60,
                            ),
                            Expanded(
                              child: RatingBar(
                                wrapAlignment: WrapAlignment.spaceAround,
                                initialRating: _rating,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: Colors.deepPurple,
                                  ),
                                  half: const Icon(
                                    Icons.star,
                                    color: Colors.deepPurple,
                                  ),
                                  empty: const Icon(
                                    Icons.star_border_sharp,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                onRatingUpdate: (rating) {
                                  debugPrint(rating.toString());
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          maxLength: 500,
                          maxLines: 10,
                          minLines: 1,
                          controller: _textEditingController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              labelText: Tr.app_google_rate_label.tr,
                              labelStyle:
                                  const TextStyle(color: Colors.deepPurple),
                              helperText: Tr.app_google_rate_optional.tr,
                              helperStyle: const TextStyle(color: Colors.grey),
                              // suffixText: "suffix",
                              // suffixIcon: Icon(Icons.done),
                              // suffixStyle: TextStyle(color: Colors.green),
                              // counterText: "20",
                              counterStyle: const TextStyle(color: Colors.grey),
                              // prefixText: "ID",
                              // prefixStyle: TextStyle(color: Colors.blue),
                              // prefixIcon: Icon(Icons.language),
                              fillColor: Colors.white,
                              filled: true,
                              //  errorText: "error",
                              //  errorMaxLines: 1,
                              //  errorStyle: TextStyle(color: Colors.red),
                              //  errorBorder: UnderlineInputBorder(),
                              hintText: Tr.app_google_rate_hint.tr,
                              hintMaxLines: 1,
                              hintStyle: const TextStyle(color: Colors.black38),
                              // icon: Icon(Icons.assignment_ind),
                              iconColor: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            // primary: Colors.black,
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(10))),
                            elevation: 2,
                            // shadowColor: Colors.orangeAccent,
                          ),
                          autofocus: false,
                          onPressed: () {
                            Get.back();
                            Http.instance.post(NetPath.updateRatedApp,
                                data: {"rating": -1, "remark": ''});
                          },
                          child: Text(
                            Tr.app_google_rate_cancel.tr,
                            style: const TextStyle(color: Colors.deepPurple),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          style: _step == 1
                              ? TextButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  // primary: Colors.white,
                                  elevation: 2,
                                  shadowColor: Colors.deepPurple)
                              : TextButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  //primary: Colors.white,
                                  elevation: 2,
                                  shadowColor: Colors.deepPurple),
                          child: Text(
                            Tr.app_report_submit.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_step == 0) return;
                            setState(() {
                              _step = 2;
                            });
                            Http.instance.post(NetPath.updateRatedApp, data: {
                              "rating": _rating,
                              "remark": _textEditingController.text
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
