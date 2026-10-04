import 'package:edencrew_assignment_starter/common/data/api/stock_api.dart';
import 'package:edencrew_assignment_starter/common/data/provider/wish_provider.dart';
import 'package:edencrew_assignment_starter/features/detail/data/model/detail_stock.dart';
import 'package:edencrew_assignment_starter/features/detail/presentation/detail_chart.dart';
import 'package:edencrew_assignment_starter/features/detail/presentation/detail_daily_table.dart';
import 'package:edencrew_assignment_starter/features/detail/presentation/detail_period_tab_bar.dart';
import 'package:edencrew_assignment_starter/features/detail/presentation/detail_summary_card.dart';
import 'package:edencrew_assignment_starter/features/detail/presentation/provider/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:edencrew_assignment_starter/common/data/storage/wish_storage.dart';
import 'package:edencrew_assignment_starter/features/detail/data/repository/detail_repository.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailProvider(
        DetailRepository(WishStorage(), StockApi()),
        context.read<WishProvider>(),
      )..load(code),
      child: const _DetailView(),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailProvider>();
    final AppColors colors = context.colors;
    final AppDimens dimens = context.dimens;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: dimens.space4 + dimens.iconMd + dimens.space3,
        titleSpacing: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: dimens.space4, right: dimens.space3),
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: colors.textSecondary,
            size: dimens.iconMd,
          ),
        ),
        title: provider.status == DetailStatus.success
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.stock!.stock.name,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 15,
                      fontWeight: AppTypography.medium,
                    ),
                  ),
                  Text(
                    '${provider.stock!.stock.code} · '
                    '${provider.stock!.stock.market}',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 11,
                      fontWeight: AppTypography.regular,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        actions: [
          if (provider.status == DetailStatus.success)
            IconButton(
              onPressed: () {
                context.read<DetailProvider>().toggleWish();
              },
              icon: Icon(
                provider.stock!.isWish ? Icons.star : Icons.star_outline,
                color: provider.stock!.isWish
                    ? context.colors.favoriteActive
                    : context.colors.favoriteInactive,
              ),
            ),
        ],
      ),
      body: switch (provider.status) {
        DetailStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),
        DetailStatus.error => Center(
          child: Text(provider.error ?? '오류가 발생했습니다.'),
        ),
        DetailStatus.success => _DetailContent(stock: provider.stock!),
      },
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.stock});

  final DetailStock stock;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailProvider>();
    final AppDimens dimens = context.dimens;
    final AppColors colors = context.colors;

    final isUp = stock.changePrice > 0;
    final isDown = stock.changePrice < 0;

    final priceFormat = NumberFormat('#,###');

    return ListView(
      padding: EdgeInsets.all(dimens.space4),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              priceFormat.format(stock.currentPrice),
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 30,
                fontWeight: AppTypography.bold,
              ),
            ),

            SizedBox(width: dimens.space2),

            Text(
              '${isUp
                  ? '▲'
                  : isDown
                  ? '▼'
                  : ''} ${priceFormat.format(stock.changePrice)} (${stock.changeRate.toStringAsFixed(2)}%)',
              style: TextStyle(
                color: isUp
                    ? colors.priceUpText
                    : isDown
                    ? colors.priceDownText
                    : colors.priceFlatText,
                fontSize: 15,
                fontWeight: AppTypography.medium,
              ),
            ),
          ],
        ),

        SizedBox(height: dimens.space4),

        Column(
          children: [
            DetailPeriodTabBar(
              selectedPeriod: provider.period,
              onPeriodSelected: provider.setPeriod,
            ),

            SizedBox(height: context.dimens.space4),

            SizedBox(
              height: 220,
              child: DetailChart(prices: provider.chartPrices),
            ),
          ],
        ),

        SizedBox(height: dimens.space4),

        DetailSummaryCard(stock: provider.stock!, priceFormat: priceFormat),

        SizedBox(height: dimens.space6),

        Text(
          '일별 시세',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: AppTypography.bold,
          ),
        ),

        SizedBox(height: dimens.space1),

        DetailDailyPriceTable(prices: provider.dailyPrices),
      ],
    );
  }
}
