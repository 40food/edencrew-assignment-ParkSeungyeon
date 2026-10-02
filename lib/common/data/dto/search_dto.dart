class SearchDto {
  final String code;
  final String name;
  final String typeCode;
  final String typeName;
  final String nationCode;
  final String category;

  const SearchDto({
    required this.code,
    required this.name,
    required this.typeCode,
    required this.typeName,
    required this.nationCode,
    required this.category,
  });

  factory SearchDto.fromJson(Map<String, dynamic> json) {
    return SearchDto(
      code: json['code'] as String,
      name: json['name'] as String,
      typeCode: json['typeCode'] as String,
      typeName: json['typeName'] as String,
      nationCode: json['nationCode'] as String,
      category: json['category'] as String,
    );
  }
}
