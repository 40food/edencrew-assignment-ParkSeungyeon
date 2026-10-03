import 'package:edencrew_assignment_starter/common/widgets/feedback_skeleton.dart';
import 'package:edencrew_assignment_starter/features/watch/data/model/watch_stock.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WatchItem extends StatelessWidget {
  const WatchItem({super.key, required this.stock});

  final WatchStock stock;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    final isUp = stock.changePrice != null && stock.changePrice! > 0;
    final isDown = stock.changePrice != null && stock.changePrice! < 0;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: context.dimens.borderHairline,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: dimens.space3,
        horizontal: dimens.space4,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          stock.stock.name,
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: AppTypography.medium,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          '${stock.stock.code} · ${stock.stock.market}',
          style: TextStyle(
            color: colors.textSecondary,
            fontWeight: AppTypography.medium,
            fontSize: 11,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            stock.currentPrice == null
                ? const FeedbackSkeleton(width: 70, height: 16)
                : Text(
                    NumberFormat('#,###').format(stock.currentPrice),
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontWeight: AppTypography.medium,
                      fontSize: 15,
                    ),
                  ),
            const SizedBox(height: 2),
            stock.changeRate == null
                ? const FeedbackSkeleton(width: 50, height: 12)
                : Text(
                    '${isUp ? '+' : ''}${NumberFormat('#,###').format(stock.changePrice)} '
                    '(${isUp ? '+' : ''}${stock.changeRate!.toStringAsFixed(2)}%)',
                    style: TextStyle(
                      color: isUp
                          ? colors.priceUpText
                          : isDown
                          ? colors.priceDownText
                          : colors.priceFlatText,
                      fontWeight: AppTypography.medium,
                      fontSize: 11,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
