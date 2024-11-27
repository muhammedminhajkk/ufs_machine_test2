class Meal {
  final String strMeal;
  final String strMealThumb;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
  });

  // Factory constructor to parse from JSON
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
    );
  }
}
