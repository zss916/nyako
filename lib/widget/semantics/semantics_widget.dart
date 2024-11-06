import 'package:flutter/cupertino.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/widget/semantics/label.dart';

extension WidgetExt on Widget {
  ///普通控件添加标签
  Widget onLabel({required String label}) => AppConstants.isSemantics
      ? Semantics(
          excludeSemantics: true,
          label: label,
          child: this,
        )
      : SizedBox(
          child: this,
        );

  ///List item 子控件添加标签
  Widget onItemLabel(
          {String label = SemanticsLabel.list, required int index}) =>
      AppConstants.isSemantics
          ? Semantics(
              excludeSemantics: true,
              label: '$label-${index + 1}',
              child: this,
            )
          : SizedBox(
              child: this,
            );

  ///List Vip item 子控件添加标签
  Widget onVipItemLabel({required int index}) =>
      onItemLabel(label: SemanticsLabel.vip, index: index);

  ///List price item 子控件添加标签
  Widget onPriceItemLabel({required int index}) =>
      onItemLabel(label: SemanticsLabel.price, index: index);

  ///List diamond item 子控件添加标签
  Widget onDiamondItemLabel({required int index}) =>
      onItemLabel(label: SemanticsLabel.diamond, index: index);

  ///List text item 子控件添加标签
  Widget onTextItemLabel({required int index}) =>
      onItemLabel(label: SemanticsLabel.text, index: index);
}
