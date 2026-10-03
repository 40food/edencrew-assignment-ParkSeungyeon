import 'package:edencrew_assignment_starter/common/data/provider/wish_provider.dart';
import 'package:edencrew_assignment_starter/features/watch/data/model/watch_stock.dart';
import 'package:edencrew_assignment_starter/features/watch/data/repository/watch_repository.dart';
import 'package:flutter/foundation.dart';

enum WatchStatus { initial, loading, success, empty, error }

class WatchProvider extends ChangeNotifier {
  final WatchRepository _repository;
  final WishProvider _wishProvider;

  WatchProvider(this._repository, this._wishProvider) {
    _wishProvider.addListener(_onWishChanged);
  }

  List<WatchStock> _stocks = [];
  WatchStatus _status = WatchStatus.initial;
  String? _error;

  List<WatchStock> get stocks => List.unmodifiable(_stocks);
  WatchStatus get status => _status;
  String? get error => _error;

  void _onWishChanged() {
    refresh();
  }

  Future<void> refresh() async {
    _status = WatchStatus.loading;
    _stocks = [];
    notifyListeners();

    try {
      await for (final stock in _repository.getStocks()) {
        final index = _stocks.indexWhere(
          (item) => item.stock.code == stock.stock.code,
        );

        if (index == -1) {
          _stocks = [..._stocks, stock];
        } else {
          final updated = [..._stocks];
          updated[index] = stock;
          _stocks = updated;
        }

        notifyListeners();
      }

      _status = _stocks.isEmpty ? WatchStatus.empty : WatchStatus.success;

      notifyListeners();
    } catch (e) {
      _status = WatchStatus.error;
      _error = '관심 종목을 불러오지 못했습니다.';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _wishProvider.removeListener(_onWishChanged);
    super.dispose();
  }
}
