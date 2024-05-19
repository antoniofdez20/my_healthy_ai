class Ingredient {
  final String text;
  final double quantity;
  final String? measure;
  final String food;
  final double weight;
  final String? foodCategory;
  final String foodId;
  final String? image;

  Ingredient({
    required this.text,
    required this.quantity,
    this.measure,
    required this.food,
    required this.weight,
    this.foodCategory,
    required this.foodId,
    this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      text: json['text'] ?? '',
      quantity: (json['quantity'] ?? 0).toDouble(),
      measure: json['measure'],
      food: json['food'] ?? '',
      weight: (json['weight'] ?? 0).toDouble(),
      foodCategory: json['foodCategory'],
      foodId: json['foodId'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'quantity': quantity,
      'measure': measure,
      'food': food,
      'weight': weight,
      'foodCategory': foodCategory,
      'foodId': foodId,
      'image': image,
    };
  }
}
