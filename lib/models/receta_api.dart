import 'package:my_healthy_ai/models/models.dart';

class RecetaApi {
  final String label;
  final String? image;
  final List<String> dietLabels;
  final List<String> healthLabels;
  final List<String> ingredientLines;
  final List<Ingredient> ingredients;
  final double calories;
  final List<String> cuisineType;
  final List<String> mealType;
  final List<String> dishType;

  RecetaApi({
    required this.label,
    this.image,
    required this.dietLabels,
    required this.healthLabels,
    required this.ingredientLines,
    required this.ingredients,
    required this.calories,
    required this.cuisineType,
    required this.mealType,
    required this.dishType,
  });

  factory RecetaApi.fromJson(Map<String, dynamic> json) {
    return RecetaApi(
      label: json['label'] ?? '',
      image: json['image'],
      dietLabels: List<String>.from(json['dietLabels'] ?? []),
      healthLabels: List<String>.from(json['healthLabels'] ?? []),
      ingredientLines: List<String>.from(json['ingredientLines'] ?? []),
      ingredients: List<Ingredient>.from(
          (json['ingredients'] ?? []).map((x) => Ingredient.fromJson(x))),
      calories: (json['calories'] ?? 0).toDouble(),
      cuisineType: List<String>.from(json['cuisineType'] ?? []),
      mealType: List<String>.from(json['mealType'] ?? []),
      dishType: List<String>.from(json['dishType'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'image': image,
      'dietLabels': dietLabels,
      'healthLabels': healthLabels,
      'ingredientLines': ingredientLines,
      'ingredients': ingredients.map((x) => x.toJson()).toList(),
      'calories': calories,
      'cuisineType': cuisineType,
      'mealType': mealType,
      'dishType': dishType,
    };
  }
}
