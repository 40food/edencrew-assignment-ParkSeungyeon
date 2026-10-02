import 'package:edencrew_assignment_starter/common/data/dto/search_dto.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    super.key,
    required this.stock,
    required this.isWish,
    required this.onTap,
  });

  final SearchDto stock;
  final bool isWish;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return ListTile(
      title: Text(stock.name),
      subtitle: Text('${stock.code} · ${stock.typeName}'),
      trailing: IconButton(
        onPressed: onTap,
        icon: Icon(
          isWish ? Icons.star : Icons.star_outline,
          color: isWish ? colors.favoriteActive : colors.favoriteInactive,
        ),
      ),
    );
  }
}
