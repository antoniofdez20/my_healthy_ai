class Ingredient {
  final String text;
  final double quantity;
  final String measure;
  final String food;
  final double weight;
  final String foodCategory;
  final String foodId;
  final String image;

  Ingredient({
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
    required this.foodCategory,
    required this.foodId,
    required this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      text: json['text'],
      quantity: json['quantity'],
      measure: json['measure'],
      food: json['food'],
      weight: json['weight'],
      foodCategory: json['foodCategory'],
      foodId: json['foodId'],
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
