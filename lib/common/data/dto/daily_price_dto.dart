class DailyPriceDto {
  final String localDate;
  final double closePrice;
  final double openPrice;
  final double highPrice;
  final double lowPrice;
  final int accumulatedTradingVolume;

  const DailyPriceDto({
    required this.localDate,
    required this.closePrice,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.accumulatedTradingVolume,
  });

  factory DailyPriceDto.fromJson(Map<String, dynamic> json) {
    return DailyPriceDto(
      localDate: json['localDate'] as String,
      closePrice: (json['closePrice'] as num).toDouble(),
      openPrice: (json['openPrice'] as num).toDouble(),
      highPrice: (json['highPrice'] as num).toDouble(),
      lowPrice: (json['lowPrice'] as num).toDouble(),
      accumulatedTradingVolume: (json['accumulatedTradingVolume'] as num)
          .toInt(),
    );
  }
}
