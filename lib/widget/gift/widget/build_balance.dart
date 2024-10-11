import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/socket/app_socket_manager.dart';
import 'package:oliapro/socket/socket_entity.dart';

class BuildBalance extends StatefulWidget {
  const BuildBalance({super.key});

  @override
  State<BuildBalance> createState() => _BuildBalanceState();
}

class _BuildBalanceState extends State<BuildBalance> {
  late final AppCallback<SocketBalance> _balanceListener;

  @override
  void initState() {
    super.initState();
    _balanceListener = (balance) {
      setState(() {
        UserInfo.to.myDetail?.userBalance?.remainDiamonds = balance.diamonds;
      });
    };
    AppSocketManager.to.addBalanceListener(_balanceListener);
  }

  @override
  void deactivate() {
    AppSocketManager.to.removeBalanceListener(_balanceListener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      Tr.app_base_balance.trArgs([
        (UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0).toString()
      ]),
      maxLines: 1,
      minFontSize: 10,
      style: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
    );
  }
}
