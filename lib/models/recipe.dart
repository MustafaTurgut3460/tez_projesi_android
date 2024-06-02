class Recipe {
  String id;
  String title;
  String description;
  int preparationTime;
  double calories;
  String imageUrl;
  User user;
  Cuisine cuisinePreference;
  List<RecipeStep> recipeSteps;
  List<RecipeIngredient> recipeIngredients;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.preparationTime,
    required this.calories,
    required this.imageUrl,
    required this.user,
    required this.cuisinePreference,
    required this.recipeSteps,
    required this.recipeIngredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      preparationTime: json['preparationTime'],
      calories: json['calories'].toDouble(),
      imageUrl: json['imageUrl'],
      user: User.fromJson(json['user']),
      cuisinePreference: Cuisine.fromJson(json['cuisinePreference']),
      recipeSteps: (json['recipeSteps'] as List)
          .map((stepJson) => RecipeStep.fromJson(stepJson))
          .toList(),
      recipeIngredients: (json['recipeIngredients'] as List)
          .map((ingredientJson) => RecipeIngredient.fromJson(ingredientJson))
          .toList(),
    );
  }
}

class Cuisine {
  String id;
  String name;
  String description;

  Cuisine({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) {
    return Cuisine(
      id: json['id'],
      name: json["name"],
      description: json['description'],
    );
  }
}

class User {
  String id;
  String name;
  String surname;

  User({
    required this.id,
    required this.name,
    required this.surname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
    );
  }
}

class RecipeStep {
  int stepNumber;
  String description;

  RecipeStep({
    required this.stepNumber,
    required this.description,
  });

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(
      stepNumber: json['stepNumber'],
      description: json['description'],
    );
  }
}

class RecipeIngredient {
  String id;
  String name;
  String description;
  double calories;
  double protein;
  double fat;
  String quantityType;
  double quantity;
  String imageUrl;

  RecipeIngredient({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.quantityType,
    required this.quantity,
    required this.imageUrl,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      fat: json['fat'].toDouble(),
      quantityType: json['quantityType'],
      quantity: json['quantity'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}
