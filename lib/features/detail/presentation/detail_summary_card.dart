import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:edencrew_assignment_starter/features/detail/data/model/detail_stock.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';

class DetailSummaryCard extends StatelessWidget {
  const DetailSummaryCard({
    super.key,
    required this.stock,
    required this.priceFormat,
  });

  final DetailStock stock;
  final NumberFormat priceFormat;

  @override
  Widget build(BuildContext context) {
    final dimens = context.dimens;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SummaryItem(
                label: '시가',
                value: priceFormat.format(stock.open),
              ),
            ),
            SizedBox(width: dimens.space2),
            Expanded(
              child: _SummaryItem(
                label: '고가',
                value: priceFormat.format(stock.high),
              ),
            ),
            SizedBox(width: dimens.space2),
            Expanded(
              child: _SummaryItem(
                label: '저가',
                value: priceFormat.format(stock.low),
              ),
            ),
          ],
        ),
        SizedBox(height: dimens.space2),
        Row(
          children: [
            Expanded(
              child: _SummaryItem(
                label: '거래량',
                value: _formatVolume(stock.volume),
              ),
            ),
            SizedBox(width: dimens.space2),
            Expanded(
              child: _SummaryItem(
                label: '시가총액',
                value: _formatMarketCap(stock.marketCap),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatVolume(int value) {
    if (value >= 100000000) {
      return '${_formatDecimal(value / 100000000)}억';
    }
    if (value >= 10000) {
      return '${_formatDecimal(value / 10000)}만';
    }
    if (value >= 1000) {
      return '${_formatDecimal(value / 1000)}천';
    }
    return NumberFormat('#,###').format(value);
  }

  String _formatMarketCap(int value) {
    if (value >= 1000000000000) {
      return '${_formatDecimal(value / 1000000000000)}조';
    }
    if (value >= 100000000) {
      return '${_formatDecimal(value / 100000000)}억';
    }
    if (value >= 10000) {
      return '${_formatDecimal(value / 10000)}만';
    }
    return NumberFormat('#,###').format(value);
  }

  String _formatDecimal(double value) {
    if (value == value.roundToDouble()) {
      return NumberFormat('#,###').format(value.toInt());
    }
    return value.toStringAsFixed(1);
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return Container(
      padding: EdgeInsets.all(dimens.space3),
      decoration: BoxDecoration(
        color: colors.surfaceSunken,
        borderRadius: BorderRadius.circular(dimens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 11,
              fontWeight: AppTypography.regular,
            ),
          ),
          SizedBox(height: dimens.space1),
          Text(
            value,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 15,
              fontWeight: AppTypography.medium,
            ),
          ),
        ],
      ),
    );
  }
}
