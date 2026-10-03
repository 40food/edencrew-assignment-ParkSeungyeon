import 'package:edencrew_assignment_starter/common/data/storage/wish_storage.dart';
import 'package:flutter/foundation.dart';

class WishProvider extends ChangeNotifier {
  final WishStorage _storage;

  WishProvider(this._storage);

  List<String> _symbols = [];

  List<String> get symbols => List.unmodifiable(_symbols);

  Future<void> load() async {
    _symbols = await _storage.getSymbols();
    notifyListeners();
  }

  Future<void> add(String code) async {
    final symbol = 'domestic:$code';
    if (_symbols.contains(symbol)) return;
    _symbols = [..._symbols, symbol];
    await _storage.saveSymbols(_symbols);
    notifyListeners();
  }

  Future<void> remove(String code) async {
    final symbol = 'domestic:$code';
    _symbols = _symbols.where((item) => item != symbol).toList();
    await _storage.saveSymbols(_symbols);
    notifyListeners();
  }
}
