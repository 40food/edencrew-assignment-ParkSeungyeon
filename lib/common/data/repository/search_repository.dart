import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dto/search_dto.dart';

class SearchRepository {
  Future<List<SearchDto>> searchStocks(String query) async {
    if (query.isEmpty) return [];

    final uri = Uri.https('ac.stock.naver.com', '/ac', {
      'q': query,
      'target': 'stock,ipo,index,marketindicator',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('종목 검색 실패');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final items = (json['items'] as List)
        .map((item) => SearchDto.fromJson(item as Map<String, dynamic>))
        .where(
          (stock) =>
              stock.nationCode == 'KOR' &&
              stock.category == 'stock' &&
              RegExp(r'^\d{6}$').hasMatch(stock.code),
        )
        .toList();

    return items;
  }
}
