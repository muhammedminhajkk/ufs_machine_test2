import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ufs_part2_machine_test/features/model/meal_model.dart';

class CategoryServices extends GetxService {
  final Dio _dio = Dio();

  Future<List<String>> fetchMealCategory() async {
    try {
      final response = await _dio
          .get('https://www.themealdb.com/api/json/v1/1/categories.php');

      if (response.statusCode == 200) {
        final mealsdata = response.data as Map<String, dynamic>;

        final List categoriesJson = mealsdata['categories'];
        final List<String> categoryNames = categoriesJson
            .map((json) => json['strCategory'] as String)
            .toList();
        return categoryNames;
      } else {
        throw Exception('something went wrong');
      }
    } catch (e) {
      throw Exception('something went wrong$e');
    }
  }

  Future<List<Meal>> fetchMeals(categoryname) async {
    final dio = Dio();
    try {
      final response = await dio.get(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryname');
      final data = response.data as Map<String, dynamic>;

      // Parse the meals
      final List mealsJson = data['meals'];
      return mealsJson.map((json) => Meal.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar('error', e.toString());
      return [];
    }
  }
}



// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';

// class CategoryService extends GetxService {
//   final String apiUrl =
//       'https://www.themealdb.com/api/json/v1/1/categories.php';

//   Future<List<String>> fetchCategories() async {
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         final List<dynamic> categories = data['categories'];
//         final categoryList = categories
//             .map<String>((category) => category['strCategory'] as String)
//             .toList();
//         return categoryList;
//       } else {
//         throw Exception('Failed to load categories');
//       }
//     } catch (e) {
//       throw Exception('Error fetching categories: $e');
//     }
//   }
// }