import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:edencrew_assignment_starter/features/detail/data/model/detail_stock.dart';

class DetailChart extends StatelessWidget {
  const DetailChart({super.key, required this.prices});

  final List<DetailPrice> prices;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    if (prices.isEmpty) {
      return const Center(child: Text('시세 데이터가 없습니다.'));
    }

    return SfCartesianChart(
      plotAreaBorderWidth: 0,

      primaryXAxis: DateTimeAxis(isVisible: false),

      primaryYAxis: NumericAxis(isVisible: false),

      series: <CandleSeries<DetailPrice, DateTime>>[
        CandleSeries<DetailPrice, DateTime>(
          dataSource: prices,
          xValueMapper: (price, _) => price.date,

          openValueMapper: (price, _) => price.openPrice.toDouble(),

          highValueMapper: (price, _) => price.highPrice.toDouble(),

          lowValueMapper: (price, _) => price.lowPrice.toDouble(),

          closeValueMapper: (price, _) => price.closePrice.toDouble(),

          bullColor: colors.chartLineUp,
          bearColor: colors.chartLineDown,

          enableTooltip: true,
        ),
      ],
    );
  }
}
