import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/widget/common_button.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildGooglePay extends StatelessWidget {
  final String price;

  const BuildGooglePay({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ARoutes.openTransferAppDialog(),
      child: Container(
        height: 72,
        width: double.maxFinite,
        margin: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 12),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(14),
            color: Colors.white12),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 15),
              child: Image.asset(
                Assets.imgGooglePayIcon,
                width: 53,
                height: 35,
                matchTextDirection: true,
              ),
            ),
            const Text("Google Pay",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            const Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 80,
              ),
              child: CommonButton(price, 18),
            ),
          ],
        ),
      ),
    );
  }
}
