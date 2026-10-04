import 'package:edencrew_assignment_starter/common/data/provider/wish_provider.dart';
import 'package:flutter/foundation.dart';

import 'package:edencrew_assignment_starter/features/detail/data/model/detail_stock.dart';
import 'package:edencrew_assignment_starter/features/detail/data/repository/detail_repository.dart';

enum DetailStatus { loading, success, error }

enum DetailPeriod { oneMonth, threeMonths, sixMonths, oneYear }

extension DetailPeriodLabel on DetailPeriod {
  String get label {
    switch (this) {
      case DetailPeriod.oneMonth:
        return '1개월';
      case DetailPeriod.threeMonths:
        return '3개월';
      case DetailPeriod.sixMonths:
        return '6개월';
      case DetailPeriod.oneYear:
        return '1년';
    }
  }
}

class DetailProvider extends ChangeNotifier {
  final DetailRepository _repository;
  final WishProvider _wishProvider;

  DetailProvider(this._repository, this._wishProvider);

  DetailStock? _stock;
  DetailStatus _status = DetailStatus.loading;
  String? _error;

  DetailStock? get stock => _stock;
  DetailStatus get status => _status;
  String? get error => _error;

  Future<void> load(String code) async {
    _status = DetailStatus.loading;
    _error = null;
    notifyListeners();

    try {
      _stock = await _repository.getStock(code);
      _status = DetailStatus.success;
    } catch (e) {
      _status = DetailStatus.error;
      _error = '종목 정보를 불러오지 못했습니다.';
    }

    notifyListeners();
  }

  Future<void> toggleWish() async {
    if (_stock == null) return;

    final code = _stock!.stock.code;

    if (_stock!.isWish) {
      await _wishProvider.remove(code);
    } else {
      await _wishProvider.add(code);
    }

    _stock = DetailStock(
      stock: _stock!.stock,
      isWish: !_stock!.isWish,
      currentPrice: _stock!.currentPrice,
      changePrice: _stock!.changePrice,
      changeRate: _stock!.changeRate,
      open: _stock!.open,
      high: _stock!.high,
      low: _stock!.low,
      volume: _stock!.volume,
      marketCap: _stock!.marketCap,
      dailyPrices: _stock!.dailyPrices,
    );

    notifyListeners();
  }

  DetailPeriod _period = DetailPeriod.oneMonth;

  DetailPeriod get period => _period;

  void setPeriod(DetailPeriod period) {
    _period = period;
    notifyListeners();
  }

  List<DetailPrice> get chartPrices {
    if (_stock == null) return [];

    switch (_period) {
      case DetailPeriod.oneMonth:
        return _stock!.oneMonth;
      case DetailPeriod.threeMonths:
        return _stock!.threeMonths;
      case DetailPeriod.sixMonths:
        return _stock!.sixMonths;
      case DetailPeriod.oneYear:
        return _stock!.oneYear;
    }
  }

  List<DetailPrice> get dailyPrices {
    return chartPrices;
  }
}
