import 'dart:convert';

import 'package:edencrew_assignment_starter/common/data/dto/daily_price_dto.dart';
import 'package:edencrew_assignment_starter/common/data/dto/metadata_dto.dart';
import 'package:edencrew_assignment_starter/common/data/dto/realtime_dto.dart';
import 'package:http/http.dart' as http;

import 'package:edencrew_assignment_starter/common/data/dto/search_dto.dart';

class StockApi {
  Future<List<SearchDto>> searchStocks(String query) async {
    final uri = Uri.https('ac.stock.naver.com', '/ac', {
      'q': query,
      'target': 'stock,ipo,index,marketindicator',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('종목 검색 실패');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return (json['items'] as List)
        .map((item) => SearchDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Stream<RealtimeDto> getRealtimeStocks(List<String> codes) async* {
    final uri = Uri.https('polling.finance.naver.com', '/api/realtime', {
      'query': 'SERVICE_ITEM:${codes.join(',')}',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('실시간 시세 조회 실패');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final result = json['result'] as Map<String, dynamic>;
    final areas = result['areas'] as List;

    for (final area in areas) {
      final datas = area['datas'] as List;

      for (final data in datas) {
        yield RealtimeDto.fromJson(data as Map<String, dynamic>);
      }
    }
  }

  Future<MetadataDto> getStockMetadata(String code) async {
    final uri = Uri.https(
      'stock.naver.com',
      '/api/securityFe/api/fchart/domestic/stock/$code',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('종목 메타데이터 조회 실패');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return MetadataDto.fromJson(json);
  }

  Future<List<DailyPriceDto>> getDailyPrices(
    String code,
    DateTime start,
    DateTime end,
  ) async {
    final uri = Uri.https(
      'api.stock.naver.com',
      '/chart/domestic/item/$code/day',
      {
        'startDateTime': _formatDateTime(start),
        'endDateTime': _formatDateTime(end),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('일봉 조회 실패');
    }

    final json = jsonDecode(response.body);

    return (json as List)
        .map((item) => DailyPriceDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  String _formatDateTime(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}'
        '${date.month.toString().padLeft(2, '0')}'
        '${date.day.toString().padLeft(2, '0')}'
        '${date.hour.toString().padLeft(2, '0')}'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}
