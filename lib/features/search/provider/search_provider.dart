import 'package:flutter/foundation.dart';

import '../../../common/data/dto/search_dto.dart';
import '../../../common/data/repository/search_repository.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepository _repository;

  SearchProvider(this._repository);

  List<SearchDto> _results = [];
  bool _isLoading = false;
  String? _error;

  List<SearchDto> get results => _results;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _results = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _results = await _repository.searchStocks(query);
    } catch (e) {
      _error = '검색에 실패했습니다.';
      _results = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
