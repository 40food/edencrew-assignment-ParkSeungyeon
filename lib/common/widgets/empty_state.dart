import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: colors.textTertiary, size: dimens.iconLg),
          SizedBox(height: dimens.space3),
          Text(
            title,
            style: TextStyle(
              fontWeight: AppTypography.bold,
              fontSize: 19,
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: dimens.space3),
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: AppTypography.regular,
              color: colors.textTertiary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
