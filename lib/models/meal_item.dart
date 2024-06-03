class MealItem {
  String id;
  String name;
  bool isSelected;

  MealItem({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      id: json['id'],
      name: json['name'],
      isSelected: false,
    );
  }
}