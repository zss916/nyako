import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/widget/common_button.dart';
import 'package:nyako/routes/a_routes.dart';

class BuildGooglePay extends StatelessWidget {
  final String price;

  const BuildGooglePay({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ARoutes.openTransferAppDialog(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64,
            width: double.maxFinite,
            margin:
                const EdgeInsetsDirectional.only(start: 12, end: 12, top: 0),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 0, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(14),
                color: Colors.white12),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 15),
                  child: Image.asset(
                    Assets.iconGooglePayIcon,
                    height: 40,
                    width: 60,
                    matchTextDirection: true,
                  ),
                ),
                const Text("Google Pay",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                const Spacer(),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 80,
                  ),
                  child: CommonButton(
                    price,
                    18,
                    h: 36,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Color(0xFFF3F3F3),
            indent: 12,
            endIndent: 12,
          )
        ],
      ),
    );
  }
}
