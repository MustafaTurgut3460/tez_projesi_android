class FoodItem {
  String id;
  String name;
  String description;
  double calories;
  double protein;
  double fat;
  String imageUrl;
  bool isSelected;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.imageUrl,
    this.isSelected = false,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      fat: json['fat'].toDouble(),
      imageUrl: json['imageUrl'],
      isSelected: false,
    );
  }
}
