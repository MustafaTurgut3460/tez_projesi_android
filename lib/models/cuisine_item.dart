class CuisineItem {
  String id;
  String name;
  String description;
  bool isSelected;

  CuisineItem({
    required this.id,
    required this.name,
    required this.description,
    this.isSelected = false,
  });

  factory CuisineItem.fromJson(Map<String, dynamic> json) {
    return CuisineItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isSelected: false,
    );
  }
}