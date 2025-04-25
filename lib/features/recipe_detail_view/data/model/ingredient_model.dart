import 'package:green_plate/features/recipe_detail_view/domain/entity/ingredient_entity.dart';

class IngredientModel extends IngredientEntity {
  IngredientModel({
    required super.name,
    required super.image,
    required super.consistency,
    required super.original,
    required super.originalName,
    required super.amount,
    required super.unit,
    required super.measures,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'],
      image: json['image'],
      consistency: json['consistency'],
      original: json['original'],
      originalName: json['originalName'],
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'],
      measures: json['measures'] ?? {},
    );
  }
}
