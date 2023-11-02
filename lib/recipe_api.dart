// import 'dart:convert';
// import 'package:food_recipe/models/recipe.dart';
// import 'package:food_recipe/models/recipes_model.dart';
// import 'package:http/http.dart' as http;
//
// class RecipeApi {
//   var url = Uri.parse('https://api.spoonacular.com/recipes/complexSearch?apiKey=89bc7b285b1449f49d0c70d3bd26e4cf&query=pasta&maxFat=25');
//   Future<List<Recipe>?> fetchRecipes() async {
//     try {
//       http.Response response = await http.get(url);
//       if (response.statusCode == 200) {
//         String data = response.body;
//         var jsonData = jsonDecode(data);
//         Recipes recipes = Recipes.fromJson(jsonData);
//         List<Recipe> recipesList = recipes.recipes.map((e) => Recipe.fromJson(e)).toList();
//         return recipesList;
//       } else {
//         print('status code = ${response.statusCode}');
//       }
//     } catch (ex) {
//       print(ex);
//     }
//     return null;
//     }
//   }
