import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:my_healthy_ai/models/models.dart';

class ApiRecipeController extends GetConnect {
  RxList<RecetaApi> recetas = <RecetaApi>[].obs;
  final recipeApiKey = dotenv.env['RECIPE_API_KEY'];
  final recipeAppId = dotenv.env['RECIPE_APP_ID'];
  final String baseUrl = 'https://api.edamam.com/api/recipes/v2?type=public&';

  Future<void> getRecipes() async {
    final response = await get(
        '${baseUrl}app_id=$recipeAppId&app_key=$recipeApiKey&cuisineType=Mediterranean');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      final data = response.body['hits'];
      print(data[0]['recipe']['label']);
    }
  }
}
