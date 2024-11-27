import 'package:get/get.dart';
import 'package:ufs_part2_machine_test/features/model/meal_model.dart';
import 'package:ufs_part2_machine_test/features/service/category_item_service.dart';

class CartItemController extends GetxController {
  var cartList = <Meal>[].obs;

  void addToCart(Meal meal) {
    cartList.add(meal);
  }

  void removeFromCart(Meal meal) {
    cartList.remove(meal);
  }
}

class MealController extends GetxController {
  var mealsList = <Meal>[].obs;
  var isLoading = true.obs;
  var selectedCategory = 'beef'.obs; // Default category is "beef"

  @override
  void onInit() {
    super.onInit();
    fetchMeal(selectedCategory.value); // Fetch meals for default category
  }

  // Fetch meals based on the selected category
  void fetchMeal(String category) async {
    try {
      isLoading.value = true;
      final meals = await CategoryItemServices().fetchMeals(category);
      mealsList.assignAll(meals);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
    fetchMeal(newCategory);
  }
}
