import 'package:edencrew_assignment_starter/common/data/model/stock.dart';

class WatchStock {
  final Stock stock;
  final int? currentPrice;
  final int? changePrice;
  final double? changeRate;

  const WatchStock({
    required this.stock,
    this.currentPrice,
    this.changePrice,
    this.changeRate,
  });
}
