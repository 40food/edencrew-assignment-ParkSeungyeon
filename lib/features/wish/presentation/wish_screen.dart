import 'package:edencrew_assignment_starter/common/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../common/widgets/label.dart';
import '../provider/wish_provider.dart';

class WishScreen extends StatelessWidget {
  const WishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final symbols = context.watch<WishProvider>().symbols;
    final AppDimens dimens = context.dimens;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(dimens.space4),
            child: const AppLabel('관심'),
          ),
          Expanded(
            child: symbols.isEmpty
                ? const EmptyState(
                    icon: Icons.star_outline,
                    title: '관심 종목이 없습니다',
                    subtitle: '검색 탭에서 종목을 찾아\n별 아이콘을 눌러 추가해 주세요.',
                  )
                : ListView.builder(
                    itemCount: symbols.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(symbols[index]));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
