import 'ingredient.dart';

class Recipe {
  late int id;
  late String title;
  late String image;
  late int readyOf;
  late List<Ingredient> ingredients;
  late String instructions;

  Recipe({required this.id,required this.title,required this.image,required this.readyOf, required this.ingredients,required this.instructions});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        id: json['id'],
        title: json['title'],
        image: json['image'],
      readyOf: json['readyInMinutes'],
      ingredients: (json['extendedIngredients'] as List).map((e) => Ingredient.fromJson(e)).toList(),
      instructions: json['instructions'],

    );
  }
}