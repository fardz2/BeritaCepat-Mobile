import 'dart:convert';

import 'package:berita_mobile/app/data/Berita.dart';
import 'package:berita_mobile/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchPageController extends GetxController {
  final search = TextEditingController();
  final RxList<Berita> searchNews = <Berita>[].obs;
  final loading = true.obs;
  var client = http.Client();

  @override
  void onInit() {
    super.onInit();
    getSearch();
  }

  Future<void> getSearch() async {
    searchNews.value = [];
    try {
      final response = await ApiService().searchNews(search.text);
      for (var news in response) {
        String imageUrl = news["thumbnail"];
        searchNews.add(Berita(
            id: news["id"],
            title: news["title"],
            titleSlug: news["title_slug"],
            thumbnail: imageUrl.replaceFirst('http://127.0.0.1:8000/', ''),
            categories: Categories(
                id: news["categories"][0]["id"],
                categoryName: news["categories"][0]["category_name"],
                categorySlug: news["categories"][0]["category_slug"])));
      }

      loading.value = false;
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
