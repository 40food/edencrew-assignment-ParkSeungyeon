import 'package:edencrew_assignment_starter/common/data/model/stock.dart';
import 'package:edencrew_assignment_starter/features/detail/presentation/detail_screen.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    super.key,
    required this.stock,
    required this.isWish,
    required this.onTap,
    required this.query,
  });

  final Stock stock;
  final bool isWish;
  final VoidCallback? onTap;
  final String query;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

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
        vertical: context.dimens.space3,
        horizontal: context.dimens.space4,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailScreen(code: stock.code)),
          );
        },
        title: _HighlightText(
          text: stock.name,
          query: query,
          highlightColor: colors.accentDefault,
          fontSize: 15,
          defaultColor: colors.textPrimary,
        ),
        subtitle: _HighlightText(
          text: '${stock.code} · ${stock.market}',
          query: query,
          highlightColor: colors.accentDefault,
          fontSize: 11,
          defaultColor: colors.textSecondary,
        ),
        trailing: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          iconSize: context.dimens.iconMd,
          onPressed: onTap,
          icon: Icon(
            isWish ? Icons.star : Icons.star_outline,
            color: isWish ? colors.favoriteActive : colors.favoriteInactive,
          ),
        ),
      ),
    );
  }
}

class _HighlightText extends StatelessWidget {
  const _HighlightText({
    required this.text,
    required this.query,
    required this.highlightColor,
    required this.fontSize,
    required this.defaultColor,
  });

  final String text;
  final String query;
  final Color highlightColor;
  final double fontSize;
  final Color defaultColor;

  @override
  Widget build(BuildContext context) {
    if (query.trim().isEmpty) {
      return Text(text);
    }

    final pattern = RegExp(RegExp.escape(query.trim()), caseSensitive: false);

    final spans = <TextSpan>[];
    var currentIndex = 0;

    for (final match in pattern.allMatches(text)) {
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: TextStyle(
              color: defaultColor,
              fontWeight: AppTypography.medium,
              fontSize: fontSize,
            ),
          ),
        );
      }

      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: TextStyle(
            color: highlightColor,
            fontWeight: AppTypography.medium,
            fontSize: fontSize,
          ),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: TextStyle(
            color: defaultColor,
            fontWeight: AppTypography.medium,
            fontSize: fontSize,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }
}
