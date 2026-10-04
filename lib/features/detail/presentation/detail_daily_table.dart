import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:edencrew_assignment_starter/features/detail/data/model/detail_stock.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';

class DetailDailyPriceTable extends StatelessWidget {
  const DetailDailyPriceTable({super.key, required this.prices});

  final List<DetailPrice> prices;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        ...prices.map((price) => _buildRow(context, price)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return _buildContainer(
      context,
      child: Row(
        children: [
          _cell(
            '날짜',
            context,
            width: 46,
            align: TextAlign.left,
            color: colors.textSecondary,
          ),
          SizedBox(width: dimens.space2),
          _cell('종가', context, color: colors.textSecondary),
          SizedBox(width: dimens.space2),
          _cell('등락', context, color: colors.textSecondary),
          SizedBox(width: dimens.space2),
          _cell('거래량', context, color: colors.textSecondary),
        ],
      ),
      borderColor: colors.borderSubtle,
    );
  }

  Widget _buildRow(BuildContext context, DetailPrice price) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    final isUp = price.changePrice > 0;
    final isDown = price.changePrice < 0;

    final changeColor = isUp
        ? colors.priceUpText
        : isDown
        ? colors.priceDownText
        : colors.textSecondary;

    return _buildContainer(
      context,
      child: Row(
        children: [
          _cell(
            DateFormat('MM.dd').format(price.date),
            context,
            width: 46,
            align: TextAlign.left,
            color: colors.textSecondary,
          ),
          SizedBox(width: dimens.space2),
          _cell(NumberFormat('#,###').format(price.closePrice), context),
          SizedBox(width: dimens.space2),
          _cell(
            '${isUp ? '+' : ''}${NumberFormat('#,###').format(price.changePrice)}',
            context,
            color: changeColor,
          ),
          SizedBox(width: dimens.space2),
          _cell(
            NumberFormat('#,###').format(price.volume),
            context,
            color: colors.textSecondary,
          ),
        ],
      ),
      borderColor: colors.borderSubtle,
    );
  }

  Widget _buildContainer(
    BuildContext context, {
    required Widget child,
    required Color borderColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.dimens.space3),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: context.dimens.borderHairline,
          ),
        ),
      ),
      child: child,
    );
  }

  Widget _cell(
    String text,
    BuildContext context, {
    double? width,
    TextAlign align = TextAlign.right,
    Color? color,
  }) {
    final child = Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color ?? context.colors.textPrimary,
        fontSize: 11,
        fontWeight: AppTypography.regular,
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: child);
    }

    return Expanded(child: child);
  }
}
