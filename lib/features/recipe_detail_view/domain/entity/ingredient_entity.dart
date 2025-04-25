class IngredientEntity {
  final String name;
  final String image;
  final String consistency;
  final String original;
  final String originalName;
  final double amount;
  final String unit;
  final Map<String, dynamic> measures;

  IngredientEntity({
    required this.name,
    required this.image,
    required this.consistency,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.measures,
  });

  factory IngredientEntity.fromJson(Map<String, dynamic> json) {
    return IngredientEntity(
      name: json['name'],
      image: json['image'],
      consistency: json['consistency'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'],
      unit: json['unit'],
      measures: json['measures'],
    );
  }
}
