import 'package:edencrew_assignment_starter/common/data/api/stock_api.dart';
import 'package:edencrew_assignment_starter/common/data/provider/wish_provider.dart';
import 'package:edencrew_assignment_starter/common/data/storage/wish_storage.dart';
import 'package:edencrew_assignment_starter/common/widgets/label.dart';
import 'package:edencrew_assignment_starter/common/widgets/empty_state.dart';
import 'package:edencrew_assignment_starter/features/watch/data/repository/watch_repository.dart';
import 'package:edencrew_assignment_starter/features/watch/presentation/provider/watch_provider.dart';
import 'package:edencrew_assignment_starter/features/watch/presentation/watch_item.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WatchProvider(
        WatchRepository(WishStorage(), StockApi()),
        context.read<WishProvider>(),
      )..refresh(),
      child: const _WatchView(),
    );
  }
}

class _WatchView extends StatelessWidget {
  const _WatchView();

  @override
  Widget build(BuildContext context) {
    final watchProvider = context.watch<WatchProvider>();
    final wishProvider = context.watch<WishProvider>();
    final AppDimens dimens = context.dimens;

    final symbols = wishProvider.symbols;

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
                : switch (watchProvider.status) {
                    WatchStatus.initial => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    WatchStatus.empty => const EmptyState(
                      icon: Icons.star_outline,
                      title: '관심 종목이 없습니다',
                      subtitle: '검색 탭에서 종목을 찾아\n별 아이콘을 눌러 추가해 주세요.',
                    ),
                    WatchStatus.error => EmptyState(
                      icon: Icons.error_outline,
                      title: '관심 종목을 불러오지 못했습니다',
                      subtitle: watchProvider.error ?? '다시 시도해 주세요.',
                    ),
                    WatchStatus.loading ||
                    WatchStatus.success => ListView.builder(
                      itemCount: watchProvider.stocks.length,
                      itemBuilder: (context, index) {
                        return WatchItem(stock: watchProvider.stocks[index]);
                      },
                    ),
                  },
          ),
        ],
      ),
    );
  }
}
