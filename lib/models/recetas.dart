class Receta {
  final String title;
  final String description;
  final String image;
  final bool isFavourite;

  Receta({
    required this.title,
    required this.description,
    required this.image,
    required this.isFavourite,
  });

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      isFavourite: json['isFavourite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'isFavourite': isFavourite,
    };
  }
}
