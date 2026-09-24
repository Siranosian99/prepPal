import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_retry_interceptor/dio_retry_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:preppal/consts/api_consts.dart';
import 'package:preppal/service/model/ai_recipes_model.dart';
import 'package:preppal/service/model/meal_cat_model.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:preppal/service/model/other_recipes_model.dart';

import '../model/food_fact_model.dart';
import '../model/meals_by_id.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConsts.mainUrl));
  final Dio _dio2 = Dio(
    BaseOptions(
      baseUrl: ApiConsts.seconderyUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  final Dio _dio3 = Dio(
      BaseOptions(
        baseUrl: ApiConsts.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    )
    ..interceptors.add(
      RetryOnConnectionChangeInterceptor(
        Dio(),
        maxRetryAttempts: 1,
        retryPost: false,
        enableLogging: true,
      ),
    );
  final Dio _dio4 = Dio(
    BaseOptions(
      baseUrl: ApiConsts.baseUrlFoodFactor,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<MealsCat>?> CatCall() async {
    List<MealsCat> meals = [];
    final result = await _dio.get('categories.php');
    // i c a
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['categories'];
        meals = m.map((e) => MealsCat.fromJson(e)).toList();
        var cbox = Hive.box<MealsCat>('category');
        await cbox.clear(); // Optional: clear old data
        await cbox.addAll(meals);
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<MealsbyCat>?> CallByCatInsdie(String category) async {
    List<MealsbyCat> inMeals = [];
    final result = await _dio.get('filter.php?c=$category');
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        inMeals = m.map((e) => MealsbyCat.fromJson(e)).toList();
        var mbox = Hive.box<MealsbyCat>('SeaFood');
        await mbox.addAll(inMeals);
        var inbox = Hive.box<MealsbyCat>('inCat');
        await inbox.addAll(inMeals);
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return inMeals;
  }

  Future<List<MealsById>?> GetMealsById(String mealId) async {
    List<MealsById> meals = [];
    List<String> ingredient = [];
    List<String> measures = [];

    final result = await _dio.get('lookup.php?i=$mealId');

    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsById.fromJson(e)).toList();

        for (int i = 1; i <= 20; i++) {
          final ing = result.data['meals'][0]['strIngredient$i'];
          final mes = result.data['meals'][0]['strMeasure$i'];
          if (ing != null && ing.toString().trim().isNotEmpty) {
            // ingredient.add(ing.toString().trim());
            // measures.add(mes.toString().trim());git
            ingredient.add(
              '$i━ ${ing.toString().trim()} :${mes.toString().trim()}\n',
            );
          }
        }
        meals[0].strIngredient = ingredient;
        meals[0].strMeasure = measures;
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<MealsById>?> GetRandomMeal() async {
    List<MealsById> meals = [];
    List<String> ingredient = [];
    List<String> measures = [];

    final result = await _dio.get('random.php');

    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data['meals'];
        meals = m.map((e) => MealsById.fromJson(e)).toList();

        for (int i = 1; i <= 20; i++) {
          final ing = result.data['meals'][0]['strIngredient$i'];
          final mes = result.data['meals'][0]['strMeasure$i'];
          if (ing != null && ing.toString().trim().isNotEmpty) {
            // ingredient.add(ing.toString().trim());
            // measures.add(mes.toString().trim());
            ingredient.add(
              '$i━ ${ing.toString().trim()} :${mes.toString().trim()}\n',
            );
          }
        }
        meals[0].strIngredient = ingredient;
        meals[0].strMeasure = measures;
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return meals;
  }

  Future<List<OtherRecipes>?> OtherRecipesCall() async {
    List<OtherRecipes> recipes = [];
    final result = await _dio2.get(
      'recipes?size=100&page=1',
      options: Options(
        headers: {
          'x-rapidapi-key':
              '05dd5ab504mshe0b8e13b84f9856p100bb3jsnf942f962d553',
          // Your API key
          'x-rapidapi-host': 'recipe-food-nutrition16.p.rapidapi.com',
          // API host from RapidAPI
        },
      ),
    );
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data["data"];
        recipes = m.map((e) => OtherRecipes.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return recipes;
  }

  Future<List<OtherRecipes>?> FoodFactsCall() async {
    List<OtherRecipes> recipes = [];
    final result = await _dio2.get(
      'recipes?size=100&page=1',
      options: Options(
        headers: {
          'x-rapidapi-key':
              '05dd5ab504mshe0b8e13b84f9856p100bb3jsnf942f962d553',
          // Your API key
          'x-rapidapi-host': 'recipe-food-nutrition16.p.rapidapi.com',
          // API host from RapidAPI
        },
      ),
    );
    try {
      if (result.statusCode == 200) {
        List<dynamic> m = result.data["data"];
        recipes = m.map((e) => OtherRecipes.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e);
    }

    return recipes;
  }

  Future<List<AiRecipeModel>?> AiRecipesGet(String query) async {
    List<AiRecipeModel> recipes = [];
    try {
      final response = await _dio3.post(
        ApiConsts.endPoint,
        data: {
          "model": ApiConsts.modelName,
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a recipe generator. Generate recipes based on the user's available ingredients.",
            },
            {"role": "user", "content": query},
          ],
          "response_format": {
            "type": "json_schema",
            "json_schema": {
              "name": "recipe",
              "strict": true,
              "schema": {
                "type": "object",
                "properties": {
                  "name": {"type": "string"},
                  "ingredients": {
                    "type": "array",
                    "items": {"type": "string"},
                  },
                  "duration": {"type": "integer"},
                  "difficulty": {
                    "type": "string",
                    "enum": ["easy", "medium", "hard"],
                  },
                  "steps": {
                    "type": "array",
                    "items": {"type": "string"},
                  },
                },
                "required": [
                  "name",
                  "ingredients",
                  "duration",
                  "difficulty",
                  "steps",
                ],
                "additionalProperties": false,
              },
            },
          },
        },
        options: Options(
          headers: {
            "Authorization": ApiConsts.apiKey,
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final content = data['choices'][0]['message']['content'];
        final jsonData = jsonDecode(content);
        final lastData = AiRecipeModel.fromJson(jsonData);
        print('-==--------');
        print(jsonEncode(lastData.toJson()));
        recipes.add(
          AiRecipeModel(
            name: lastData.name,
            ingredients: lastData.ingredients,
            duration: lastData.duration,
            difficulty: lastData.difficulty,
            steps: lastData.steps,
          ),
        );
        print(recipes);
        return recipes;
      }

      throw Exception("Unexpected status code: ${response.statusCode}");
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      debugPrint("DioException");
      debugPrint("Status Code: $statusCode");
      debugPrint("Message: ${e.message}");
      debugPrint("Response: ${e.response?.data}");

      final bool shouldRetry =
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError ||
          statusCode == 500 ||
          statusCode == 502 ||
          statusCode == 503 ||
          statusCode == 504;
    } catch (e) {
      debugPrint("Unexpected error: $e");
      throw Exception("Something went wrong.");
    }
    return null;
  }

  Future<List<NutritionProduct>?> FoodFactsGet(String query) async {
    List<NutritionProduct> foods = [];
    try {
      final response = await _dio4.get(
        ApiConsts.baseUrlFoodFactor,
        queryParameters: {
          'categories_tags_en': query,
          'page_size': 20,
          'fields': 'product_name,brands,nutriments',
        },
      );

      if (response.statusCode == 200) {
        final products = response.data['products'];
        for (final product in products) {
          foods.add(
            NutritionProduct.fromJson(product),
          );
          // print('-------------------');
          // print('Name: ${product['product_name']}');
          // print('Brand: ${product['brands']}');
          // print('Code: ${product['code']}');
        }
        // final content = data['choices'][0]['message']['content'];
        // final jsonData = jsonDecode(content);
        // final lastData = AiRecipeModel.fromJson(jsonData);
        // print('-==--------');
        // print(jsonEncode(lastData.toJson()));
        // recipes.add(
        //   AiRecipeModel(
        //     name: lastData.name,
        //     ingredients: lastData.ingredients,
        //     duration: lastData.duration,
        //     difficulty: lastData.difficulty,
        //     steps: lastData.steps,
        //   ),
        // );
        print("-----------");
      }
      print("foods$foods");
      return foods;
      throw Exception("Unexpected status code: ${response.statusCode}");
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      debugPrint("DioException");
      debugPrint("Status Code: $statusCode");
      debugPrint("Message: ${e.message}");
      debugPrint("Response: ${e.response?.data}");

      final bool shouldRetry =
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError ||
          statusCode == 500 ||
          statusCode == 502 ||
          statusCode == 503 ||
          statusCode == 504;
    } catch (e) {
      debugPrint("Unexpected error: $e");
      throw Exception("Something went wrong.");
    }
    return null;
  }
}

String _getErrorMessage(DioException e) {
  final statusCode = e.response?.statusCode;

  if (e.type == DioExceptionType.connectionError) {
    return "No internet connection. Please check your network.";
  }

  if (e.type == DioExceptionType.connectionTimeout) {
    return "Unable to connect to the server.";
  }

  if (e.type == DioExceptionType.sendTimeout) {
    return "The request could not be sent. Please try again.";
  }

  if (e.type == DioExceptionType.receiveTimeout) {
    return "The server took too long to respond.";
  }

  switch (statusCode) {
    case 400:
      return "Bad request.";
    case 401:
      return "Token is invalid or missing.";
    case 403:
      return "You do not have permission to perform this action.";
    case 404:
      return "The endpoint or requested resource was not found.";
    case 405:
      return "The HTTP method used is not allowed.";
    case 408:
      return "The request timed out.";
    case 409:
      return "The request conflicts with the current state.";
    case 422:
      return "The data sent cannot be processed.";
    case 429:
      return "Too many requests were sent. Rate limit exceeded.";
    case 500:
      return "An error occurred on the API server.";
    case 502:
      return "There is a problem with the gateway or proxy.";
    case 503:
      return "The API is currently unavailable.";
    case 504:
      return "The server did not respond in time.";
    default:
      return "Something went wrong.";
  }
}
