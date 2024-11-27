import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ufs_part2_machine_test/features/model/meal_model.dart';

class CategoryItemServices extends GetxService {
  Future<List<Meal>> fetchMeals(String categoryname) async {
    try {
      final mealname = Uri.encodeQueryComponent(categoryname);
      final dio = Dio();

      final response = await dio.get(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=$mealname');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data);
        final List<dynamic> mealsList = data['meals'];
        final List<Meal> meals =
            mealsList.map((e) => Meal.fromJson(e)).toList();
        return meals;
      }
      return [];
    } catch (e) {
      Get.snackbar('error', e.toString());
      return [];
    }
  }
}
