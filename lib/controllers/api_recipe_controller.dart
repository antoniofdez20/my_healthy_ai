import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/models/models.dart';

class ApiRecipeController extends GetConnect {
  final recipeApiKey = dotenv.env['RECIPE_API_KEY'];
  final recipeAppId = dotenv.env['RECIPE_APP_ID'];
  final String baseUrl = 'https://api.edamam.com/api/recipes/v2?type=public&';

  Future<List<RecetaApi>> getRecipes() async {
    final response = await get(
        '${baseUrl}app_id=$recipeAppId&app_key=$recipeApiKey&cuisineType=Mediterranean');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      final List<dynamic> data = response.body['hits'];
      return data.map((hit) => RecetaApi.fromJson(hit['recipe'])).toList();
    }
  }

  Future<List<RecetaApi>> getRecipesMealType(String mealType) async {
    final response = await get(
        '${baseUrl}app_id=$recipeAppId&app_key=$recipeApiKey&mealType=$mealType');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      final List<dynamic> data = response.body['hits'];
      return data.map((hit) => RecetaApi.fromJson(hit['recipe'])).toList();
    }
  }

  Future<List<RecetaApi>> getRecipesCuisineType(String cuisineType) async {
    final response = await get(
        '${baseUrl}app_id=$recipeAppId&app_key=$recipeApiKey&cuisineType=$cuisineType');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      final List<dynamic> data = response.body['hits'];
      return data.map((hit) => RecetaApi.fromJson(hit['recipe'])).toList();
    }
  }

  Future<List<RecetaApi>> getRecipesQuery(String query) async {
    final response = await get(
        '${baseUrl}q=$query&app_id=$recipeAppId&app_key=$recipeApiKey');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      final List<dynamic> data = response.body['hits'];
      return data.map((hit) => RecetaApi.fromJson(hit['recipe'])).toList();
    }
  }
}
