import 'package:edencrew_assignment_starter/features/search/data/provider/search_provider.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final AppDimens dimens = context.dimens;
    final AppColors colors = context.colors;

    return TextField(
      controller: controller,
      onChanged: (query) {
        context.read<SearchProvider>().search(query);
      },
      style: TextStyle(
        color: colors.textPrimary,
        fontSize: 15,
        fontWeight: AppTypography.medium,
      ),
      decoration: InputDecoration(
        hintText: '종목명 또는 종목코드',
        hintStyle: TextStyle(
          color: colors.textTertiary,
          fontSize: 15,
          fontWeight: AppTypography.medium,
        ),

        prefixIcon: Padding(
          padding: EdgeInsets.only(
            top: dimens.space3,
            bottom: dimens.space3,
            left: dimens.space3,
            right: dimens.space2,
          ),
          child: Icon(
            Icons.search,
            color: colors.textTertiary,
            size: dimens.iconSm,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.close,
            color: colors.textTertiary,
            size: dimens.iconSm,
          ),
          onPressed: () {
            controller.clear();
            context.read<SearchProvider>().search('');
          },
        ),

        filled: true,
        fillColor: colors.surfaceSunken,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimens.radiusMd),
          borderSide: BorderSide(color: colors.borderStrong),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimens.radiusMd),
          borderSide: BorderSide(color: colors.borderStrong),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimens.radiusMd),
          borderSide: BorderSide(color: colors.borderStrong),
        ),
      ),
    );
  }
}
