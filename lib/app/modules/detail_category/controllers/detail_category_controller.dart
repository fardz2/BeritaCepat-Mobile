import 'package:berita_mobile/app/data/Berita.dart';
import 'package:berita_mobile/services/api_service.dart';
import 'package:get/get.dart';

class DetailCategoryController extends GetxController {
  //TODO: Implement DetailCategoryController

  final count = 0.obs;
  final loading = false.obs;
  final category_news = <Berita>[].obs;
  final slug = Get.arguments[0];
  final title = Get.arguments[1];
  @override
  void onInit() {
    super.onInit();
    getDetailCategory();
  }

  Future<void> getDetailCategory() async {
    loading.value = true;
    category_news.value = [];
    try {
      final response = await ApiService().getDetailCategory(slug);
      final categoriesData =
          response["news"] as List; // Mengasumsikan respons berisi list news
      print(categoriesData);
      for (var category_detail in categoriesData) {
        print(category_detail);
        category_news.add(Berita(
          id: category_detail["id"],
          title: category_detail["title"],
          titleSlug: category_detail["title_slug"],
          thumbnail: category_detail["thumbnail"],
          categories: Categories(
            id: response["id"],
            categoryName: response["category_name"],
            categorySlug: response["category_slug"],
          ),
        ));
      }
    } catch (e) {
      print(e.toString());
      // Handle the error appropriately
    } finally {
      loading.value = false;
    }
  }

  void increment() => count.value++;
}
