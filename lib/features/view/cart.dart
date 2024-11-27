import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ufs_part2_machine_test/features/controller/meals_cartitems_controller.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final CartItemController cartController = Get.find<CartItemController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.cartList.isEmpty) {
          return const Center(child: Text("No items in the cart"));
        }

        return ListView.builder(
          itemCount: cartController.cartList.length,
          itemBuilder: (context, index) {
            final meal = cartController.cartList[index];
            return ListTile(
              leading: Image.network(meal.strMealThumb, width: 50, height: 50),
              title: Text(meal.strMeal),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  cartController.removeFromCart(meal);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
