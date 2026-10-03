import 'package:edencrew_assignment_starter/common/data/api/stock_api.dart';
import 'package:edencrew_assignment_starter/common/data/model/stock.dart';

class SearchRepository {
  final StockApi _api;

  SearchRepository(this._api);

  Future<List<Stock>> searchStocks(String query) async {
    if (query.isEmpty) return [];

    final dtos = await _api.searchStocks(query);

    return dtos
        .where(
          (dto) =>
              dto.nationCode == 'KOR' &&
              dto.category == 'stock' &&
              RegExp(r'^\d{6}$').hasMatch(dto.code),
        )
        .map(
          (dto) => Stock(code: dto.code, name: dto.name, market: dto.typeName),
        )
        .toList();
  }
}
