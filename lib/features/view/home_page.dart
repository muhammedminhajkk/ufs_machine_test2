import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufs_part2_machine_test/features/controller/category_controller.dart';
import 'package:ufs_part2_machine_test/features/controller/meals_cartitems_controller.dart';
import 'package:ufs_part2_machine_test/features/view/cart.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    final categoryController = Get.find<CategoryController>();
    if (categoryController.categories.isEmpty) {
      categoryController.fetchCategories();
    }
    final MealController mealController = Get.put(MealController());
    final CartItemController cartItemController = Get.put(CartItemController());

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Obx(() {
              if (categoryController.isLoading.value) {
                return const CircularProgressIndicator();
              } else if (categoryController.categories.isEmpty) {
                return const Text('No categories available');
              }

              return DropdownButton<String>(
                value: categoryController.selectedCategory.value.isEmpty
                    ? null
                    : categoryController.selectedCategory.value,
                hint: Text(mealController.selectedCategory.toString()),
                isExpanded: true,
                items: categoryController.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newCategory) {
                  if (newCategory != null) {
                    mealController.changeCategory(newCategory);
                  }
                },
              );
            }),
            Obx(() {
              if (mealController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (mealController.mealsList.isEmpty) {
                return const Center(child: Text('No meals found'));
              }

              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: mealController.mealsList.length,
                  itemBuilder: (context, index) {
                    final meal = mealController.mealsList[index];
                    return Stack(
                      children: [
                        Image.network(meal.strMealThumb),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 4),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.yellow),
                            child: IconButton(
                                onPressed: () {
                                  cartItemController.addToCart(meal);
                                },
                                icon: const Icon(Icons.add)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: Text(
                              meal.strMeal,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Cart()),
            );
          },
          child: const Icon(Icons.shopping_cart_checkout_outlined),
        ),
      ),
    );
  }
}
