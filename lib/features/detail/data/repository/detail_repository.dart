import 'package:edencrew_assignment_starter/common/data/dto/daily_price_dto.dart';
import 'package:edencrew_assignment_starter/common/data/model/stock.dart';
import 'package:edencrew_assignment_starter/common/data/storage/wish_storage.dart';
import 'package:edencrew_assignment_starter/common/data/api/stock_api.dart';
import 'package:edencrew_assignment_starter/features/detail/data/model/detail_stock.dart';

class DetailRepository {
  final WishStorage _storage;
  final StockApi _api;

  DetailRepository(this._storage, this._api);

  Future<DetailStock> getStock(String code) async {
    final metadata = await _api.getStockMetadata(code);

    final stock = Stock(
      code: metadata.symbolCode,
      name: metadata.stockName,
      market: metadata.stockExchangeNameKor,
    );

    final isWish = (await _storage.getSymbols()).contains('domestic:$code');

    final realtime = await _getRealtime(code);

    final now = DateTime.now();

    final dailyDtos = await _api.getDailyPrices(
      code,
      now.subtract(const Duration(days: 370)),
      now,
    );

    final dailyPrices = _toDailyPrices(dailyDtos);

    return DetailStock(
      stock: stock,
      isWish: isWish,
      currentPrice: realtime.currentPrice,
      changePrice: realtime.currentPrice - realtime.previousClose,
      changeRate: realtime.previousClose == 0
          ? 0
          : (realtime.currentPrice - realtime.previousClose) /
                realtime.previousClose *
                100,
      open: realtime.open,
      high: realtime.high,
      low: realtime.low,
      volume: realtime.volume,
      marketCap: realtime.currentPrice * realtime.listedStockCount,
      dailyPrices: dailyPrices,
    );
  }

  Future<dynamic> _getRealtime(String code) async {
    await for (final dto in _api.getRealtimeStocks([code])) {
      return dto;
    }

    throw Exception('실시간 시세를 불러오지 못했습니다.');
  }

  List<DetailPrice> _toDailyPrices(List<DailyPriceDto> dtos) {
    final result = <DetailPrice>[];

    for (var i = 0; i < dtos.length; i++) {
      final dto = dtos[i];

      final date = DateTime.parse(
        '${dto.localDate.substring(0, 4)}-'
        '${dto.localDate.substring(4, 6)}-'
        '${dto.localDate.substring(6, 8)}',
      );

      final previousClose = i == 0 ? dto.closePrice : dtos[i - 1].closePrice;

      final changePrice = (dto.closePrice - previousClose).toInt();

      final changeRate = previousClose == 0
          ? 0.0
          : changePrice / previousClose * 100;

      result.add(
        DetailPrice(
          date: date,
          openPrice: dto.openPrice.toInt(),
          closePrice: dto.closePrice.toInt(),
          highPrice: dto.highPrice.toInt(),
          lowPrice: dto.lowPrice.toInt(),
          changePrice: changePrice,
          changeRate: changeRate,
          volume: dto.accumulatedTradingVolume,
        ),
      );
    }

    return result;
  }

  String _formatDateTime(DateTime date) {
    String two(int value) => value.toString().padLeft(2, '0');

    return '${date.year}'
        '${two(date.month)}'
        '${two(date.day)}'
        '${two(date.hour)}'
        '${two(date.minute)}';
  }
}
