import 'package:edencrew_assignment_starter/common/data/model/stock.dart';

class DetailStock {
  final Stock stock;
  final bool isWish;

  final int currentPrice;
  final int changePrice;
  final double changeRate;

  final int open;
  final int high;
  final int low;
  final int volume;
  final int marketCap;

  final List<DetailPrice> dailyPrices;

  const DetailStock({
    required this.stock,
    required this.isWish,
    required this.currentPrice,
    required this.changePrice,
    required this.changeRate,
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.marketCap,
    required this.dailyPrices,
  });

  List<DetailPrice> get oneMonth => _pricesFrom(const Duration(days: 30));

  List<DetailPrice> get threeMonths => _pricesFrom(const Duration(days: 90));

  List<DetailPrice> get sixMonths => _pricesFrom(const Duration(days: 180));

  List<DetailPrice> get oneYear => _pricesFrom(const Duration(days: 365));

  List<DetailPrice> _pricesFrom(Duration duration) {
    if (dailyPrices.isEmpty) return [];

    final start = DateTime.now().subtract(duration);

    return dailyPrices.where((price) {
      return price.date.isAfter(start) || price.date.isAtSameMomentAs(start);
    }).toList();
  }
}

class DetailPrice {
  final DateTime date;
  final int closePrice;
  final int changePrice;
  final double changeRate;
  final int volume;

  const DetailPrice({
    required this.date,
    required this.closePrice,
    required this.changePrice,
    required this.changeRate,
    required this.volume,
  });
}
