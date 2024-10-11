import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/dialogs/pay_channel/widget/pay_button.dart';
import 'package:oliapro/dialogs/reward_dialog/pdd_util.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/pages/charge/billing.dart';

class BuildContent extends StatelessWidget {
  final List<PayQuickChannel> data;
  final int? countryCode;
  final String? createPath;
  final String? upid;

  const BuildContent(this.data,
      {super.key, this.countryCode, this.createPath, this.upid});

  @override
  Widget build(BuildContext context) {
    return buildPayList(data, countryCode, createPath);
  }

  ///支付列表
  Widget buildPayList(
      List<PayQuickChannel> data, int? countryCode, String? createPath,
      {String? upid}) {
    /*data.forEach((element) {
      debugPrint("buildPayList===>>>> ${element.toJson()}");
    });*/

    return Container(
      //color: Colors.blueAccent,
      width: double.maxFinite,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsetsDirectional.only(bottom: 30),
          itemCount: data.length,
          itemBuilder: (context, index) {
            PayQuickChannel channelData = data[index];
            return Container(
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.only(
                start: 15,
                end: 15,
                top: 10,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () async {
                    PddUtil.instance.clickPayChannel();
                    Billing.createQPay(channelData,
                        countryCode: countryCode,
                        createPath: createPath,
                        upid: upid);
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(14),
                        color: Colors.white12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 38,
                                width: 56,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                margin:
                                    const EdgeInsetsDirectional.only(end: 10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  child: Image.network(
                                    channelData.nationalFlagPath ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  channelData.ccName ?? "--",
                                  maxLines: 1,
                                  minFontSize: 10,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 80,
                          ),
                          child: PayButton(channelData.showPrice, 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
