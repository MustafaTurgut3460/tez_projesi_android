class AiRepcipe {
  String id;
  String userId;
  String name;
  String description;
  int preparationTime;
  int servings;
  double calories;
  double protein;
  double fat;
  double carbohydrates;
  List<AiRepcipeStep> aiInstructions;
  List<AiRepcipeIngredient> aiIngredients;

  AiRepcipe({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.preparationTime,
    required this.servings,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
    required this.aiInstructions,
    required this.aiIngredients,
  });

  factory AiRepcipe.fromJson(Map<String, dynamic> json) {
    return AiRepcipe(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      description: json['description'],
      preparationTime: json['preparationTime'],
      servings: json['servings'],
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      fat: json['fat'].toDouble(),
      carbohydrates: json['carbohydrates'].toDouble(),
      aiInstructions: (json['aiInstructions'] as List)
          .map((stepJson) => AiRepcipeStep.fromJson(stepJson))
          .toList(),
      aiIngredients: (json['aiIngredients'] as List)
          .map((ingredientJson) => AiRepcipeIngredient.fromJson(ingredientJson))
          .toList(),
    );
  }
}

class AiRepcipeStep {
  int stepNumber;
  String description;

  AiRepcipeStep({
    required this.stepNumber,
    required this.description,
  });

  factory AiRepcipeStep.fromJson(Map<String, dynamic> json) {
    return AiRepcipeStep(
      stepNumber: json['stepNumber'],
      description: json['description'],
    );
  }
}

class AiRepcipeIngredient {
  String name;
  String description;
  double calories;
  double protein;
  double fat;
  double carbohydrates;
  String quantityType;
  double quantity;

  AiRepcipeIngredient({
    required this.name,
    required this.description,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
    required this.quantityType,
    required this.quantity,
  });

  factory AiRepcipeIngredient.fromJson(Map<String, dynamic> json) {
    return AiRepcipeIngredient(
      name: json['name'],
      description: json['description'],
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      fat: json['fat'].toDouble(),
      carbohydrates: json['carbohydrates'].toDouble(),
      quantityType: json['quantityType'],
      quantity: json['quantity'].toDouble(),
    );
  }
}
