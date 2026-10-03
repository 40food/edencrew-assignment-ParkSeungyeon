import 'package:edencrew_assignment_starter/common/widgets/label.dart';
import 'package:edencrew_assignment_starter/features/watch/presentation/provider/watch_provider.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchSortButton extends StatelessWidget {
  const WatchSortButton({super.key, required this.sort});

  final WatchSort sort;

  @override
  Widget build(BuildContext context) {
    final AppDimens dimens = context.dimens;
    final AppColors colors = context.colors;

    return InkWell(
      onTap: () {
        final provider = context.read<WatchProvider>();
        showModalBottomSheet(
          context: context,
          backgroundColor: colors.surfaceOverlay, //화장실
          builder: (_) => WatchSortBottomSheet(
            selectedSort: sort,
            onSortSelected: provider.setSort,
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            sort.label,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 13,
              fontWeight: AppTypography.bold,
            ),
          ),
          Icon(
            Icons.arrow_downward,
            size: dimens.iconMd,
            color: colors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class WatchSortBottomSheet extends StatelessWidget {
  const WatchSortBottomSheet({
    super.key,
    required this.selectedSort,
    required this.onSortSelected,
  });

  final WatchSort selectedSort;
  final ValueChanged<WatchSort> onSortSelected;

  @override
  Widget build(BuildContext context) {
    final AppDimens dimens = context.dimens;
    final AppColors colors = context.colors;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dimens.space5,
              horizontal: dimens.space6,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppLabel('정렬'),
            ),
          ),
          ...WatchSort.values.map((sort) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: dimens.space6,
                  vertical: dimens.space4,
                ),
                child: Text(
                  sort.label,
                  style: TextStyle(
                    color: sort == selectedSort
                        ? colors.textPrimary
                        : colors.textSecondary,
                    fontWeight: AppTypography.medium,
                  ),
                ),
              ),
              trailing: sort == selectedSort
                  ? Padding(
                      padding: EdgeInsets.only(right: dimens.space6),
                      child: Icon(Icons.check, color: colors.textPrimary),
                    )
                  : null,
              onTap: () {
                onSortSelected(sort);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}
