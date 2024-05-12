class HealthItem {
  String id;
  String name;
  String description;
  bool isSelected;

  HealthItem({
    required this.id,
    required this.name,
    required this.description,
    this.isSelected = false,
  });

  factory HealthItem.fromJson(Map<String, dynamic> json) {
    return HealthItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isSelected: false,
    );
  }
}