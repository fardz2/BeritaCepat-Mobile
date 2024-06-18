import 'package:berita_mobile/app/data/Berita.dart';
import 'package:berita_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:berita_mobile/services/api_service.dart';
import 'package:berita_mobile/services/user_check.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<Berita> beritaTerbaru = <Berita>[].obs;
  final RxList<Berita> trending = <Berita>[].obs;
  final RxList<Berita> recomendation = <Berita>[].obs;
  final RxList<Categories> categories = <Categories>[].obs;
  var user_check = UserCheck();
  var user_login = false.obs;
  var loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    user_check.box.read('token') == null
        ? user_login.value = false
        : user_login.value = true;

    getBerita();
    getCategory();
  }

  void getSatusLoginUser() {
    user_check.box.read('token') == null
        ? user_login.value = false
        : user_login.value = true;
  }

  Future<void> getBerita() async {
    loading.value = true;
    beritaTerbaru.clear();
    trending.clear();
    recomendation.clear();
    try {
      final response = await ApiService().getBerita();
      final newsBaruData = response["news_baru"];

      for (var newsData in newsBaruData) {
        beritaTerbaru.add(Berita(
            id: newsData["id"],
            title: newsData["title"],
            titleSlug: newsData["title_slug"],
            thumbnail: newsData["thumbnail"],
            categories: Categories(
                id: newsData["categories"][0]["id"],
                categoryName: newsData["categories"][0]["category_name"],
                categorySlug: newsData["categories"][0]["category_slug"])));
      }
      final trendingsData = response["trendings"];
      for (var trendingData in trendingsData) {
        trending.add(Berita(
            id: trendingData["id"],
            title: trendingData["title"],
            titleSlug: trendingData["title_slug"],
            thumbnail: trendingData["thumbnail"],
            categories: Categories(
                id: trendingData["categories"][0]["id"],
                categoryName: trendingData["categories"][0]["category_name"],
                categorySlug: trendingData["categories"][0]["category_slug"])));
      }

      final recomendationData = response["recomendation"];
      for (var recomendationNews in recomendationData) {
        recomendation.add(Berita(
            id: recomendationNews["id"],
            title: recomendationNews["title"],
            titleSlug: recomendationNews["title_slug"],
            thumbnail: recomendationNews["thumbnail"],
            categories: Categories(
                id: recomendationNews["categories"][0]["id"],
                categoryName: recomendationNews["categories"][0]
                    ["category_name"],
                categorySlug: recomendationNews["categories"][0]
                    ["category_slug"])));
      }
      loading.value = false;
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> getCategory() async {
    loading.value = true;
    categories.clear();

    try {
      final response = await ApiService().getCategory();
      final categoriesData = response["data"];

      for (var category in categoriesData) {
        categories.add(Categories(
          id: category["id"],
          categoryName: category["category_name"],
          categorySlug: category["category_slug"],
        ));
      }
    } catch (e) {
      print(e.toString());
      // Handle the error appropriately
    } finally {
      loading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await ApiService().logout();
      getSatusLoginUser();
      Get.snackbar(
        "Logout",
        "Logout Berhasil",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print(e);
    }
  }
}
