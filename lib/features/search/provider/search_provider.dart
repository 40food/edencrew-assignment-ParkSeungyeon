import 'package:flutter/foundation.dart';

import '../../../common/data/dto/search_dto.dart';
import '../../../common/data/repository/search_repository.dart';

enum SearchStatus { initial, loading, success, empty, error }

class SearchProvider extends ChangeNotifier {
  final SearchRepository _repository;

  SearchProvider(this._repository);

  List<SearchDto> _results = [];
  SearchStatus _status = SearchStatus.initial;
  String? _error;

  List<SearchDto> get results => List.unmodifiable(_results);
  SearchStatus get status => _status;
  String? get error => _error;

  int _searchId = 0;

  Future<void> search(String query) async {
    final searchId = ++_searchId;

    if (query.trim().isEmpty) {
      _results = [];
      _error = null;
      _status = SearchStatus.initial;
      notifyListeners();
      return;
    }

    _status = SearchStatus.loading;
    _error = null;
    notifyListeners();

    try {
      final results = await _repository.searchStocks(query);
      if (searchId != _searchId) return;
      _results = results;
      _status = results.isEmpty ? SearchStatus.empty : SearchStatus.success;
    } catch (e) {
      if (searchId != _searchId) return;

      _results = [];
      _error = '검색에 실패했습니다.';
      _status = SearchStatus.error;
    }

    notifyListeners();
  }
}
