import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: dimens.borderHairline,
            color: colors.borderSubtle,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: colors.navActive,
        selectedFontSize: 11,
        unselectedItemColor: colors.navInactive,
        unselectedFontSize: 11,
        iconSize: dimens.iconMd,
        backgroundColor: colors.surfaceRaised,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            activeIcon: Icon(Icons.star),
            label: '관심',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: '검색',
          ),
        ],
      ),
    );
  }
}
