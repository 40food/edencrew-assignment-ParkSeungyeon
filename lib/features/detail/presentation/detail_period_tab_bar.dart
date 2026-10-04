import 'package:edencrew_assignment_starter/features/detail/presentation/provider/detail_provider.dart';
import 'package:flutter/material.dart';

import 'package:edencrew_assignment_starter/theme/theme.dart';

class DetailPeriodTabBar extends StatelessWidget {
  const DetailPeriodTabBar({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  final DetailPeriod selectedPeriod;
  final ValueChanged<DetailPeriod> onPeriodSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return Row(
      children: DetailPeriod.values.map((period) {
        final selected = selectedPeriod == period;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: period != DetailPeriod.values.last ? dimens.space1 : 0,
            ),
            child: GestureDetector(
              onTap: () => onPeriodSelected(period),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: dimens.space1),
                decoration: BoxDecoration(
                  color: selected ? colors.accentBg : null,
                  borderRadius: BorderRadius.circular(dimens.radiusMd),
                ),
                child: Text(
                  period.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected
                        ? colors.accentDefault
                        : colors.textSecondary,
                    fontSize: 13,
                    fontWeight: AppTypography.regular,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
