import 'package:get/get.dart';
import 'package:ufs_part2_machine_test/features/service/category_service.dart';

class CategoryController extends GetxController {
  var categories = <String>[].obs;
  var isLoading = true.obs;
  var selectedCategory = ''.obs;

  Future<void> fetchCategories() async {
    try {
      final fetchedCategory =
          await Get.find<CategoryServices>().fetchMealCategory();

      categories.value = fetchedCategory;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
