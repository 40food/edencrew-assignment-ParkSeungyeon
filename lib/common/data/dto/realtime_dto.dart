class RealtimeDto {
  final String symbol;
  final int currentPrice;
  final int previousClose;
  final int open;
  final int high;
  final int low;
  final int volume;
  final int listedStockCount;

  const RealtimeDto({
    required this.symbol,
    required this.currentPrice,
    required this.previousClose,
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.listedStockCount,
  });

  factory RealtimeDto.fromJson(Map<String, dynamic> json) {
    return RealtimeDto(
      symbol: json['cd'] as String,
      currentPrice: (json['nv'] as num).toInt(),
      previousClose: (json['pcv'] as num).toInt(),
      open: (json['ov'] as num).toInt(),
      high: (json['hv'] as num).toInt(),
      low: (json['lv'] as num).toInt(),
      volume: (json['aq'] as num).toInt(),
      listedStockCount: (json['countOfListedStock'] as num).toInt(),
    );
  }
}
