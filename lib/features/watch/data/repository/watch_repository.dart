import 'package:edencrew_assignment_starter/common/data/api/stock_api.dart';
import 'package:edencrew_assignment_starter/common/data/model/stock.dart';
import 'package:edencrew_assignment_starter/common/data/storage/wish_storage.dart';
import 'package:edencrew_assignment_starter/features/watch/data/model/watch_stock.dart';

class WatchRepository {
  final WishStorage _storage;
  final StockApi _api;

  WatchRepository(this._storage, this._api);

  Stream<WatchStock> getStocks() async* {
    final symbols = await _storage.getSymbols();

    if (symbols.isEmpty) return;

    final codes = symbols
        .map((symbol) => symbol.replaceFirst('domestic:', ''))
        .toList();

    final stocks = <String, Stock>{};

    for (final code in codes) {
      final metadata = await _api.getStockMetadata(code);
      final stock = Stock(
        code: metadata.symbolCode,
        name: metadata.stockName,
        market: metadata.stockExchangeNameKor,
      );
      stocks[code] = stock;
      yield WatchStock(stock: stock);
    }

    await for (final dto in _api.getRealtimeStocks(codes)) {
      final stock = stocks[dto.symbol];
      if (stock == null) continue;
      final changePrice = dto.currentPrice - dto.previousClose;
      final changeRate = dto.previousClose == 0
          ? 0.0
          : changePrice / dto.previousClose * 100;
      yield WatchStock(
        stock: stock,
        currentPrice: dto.currentPrice,
        changePrice: changePrice,
        changeRate: changeRate,
      );
    }
  }
}
