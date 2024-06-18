import 'dart:convert';

import 'package:berita_mobile/app/data/Berita.dart';
import 'package:berita_mobile/app/data/Comment.dart';
import 'package:berita_mobile/app/data/User.dart';
import 'package:berita_mobile/services/api_service.dart';

import 'package:berita_mobile/services/user_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailController extends GetxController {
  var slug = Get.arguments;
  final comment = TextEditingController();
  final Rx<Berita> detailBerita = Berita().obs;
  final RxList<User> comments = <User>[].obs;
  var client = http.Client();
  var loading = false.obs;
  var user_check = UserCheck();

  @override
  void onInit() {
    super.onInit();
    getDetail();
  }

  Future<void> getDetail() async {
    loading.value = true;
    print(user_check.box.read("id").toString());
    try {
      final response = await ApiService().getDetail(slug);
      String imageUrl = response["thumbnail"];
      var commentsData = response["comments"];
      detailBerita.value = Berita(
          id: response["id"],
          title: response["title"],
          content: response['content'],
          thumbnail: imageUrl.replaceFirst('http://127.0.0.1:8000/', ''),
          categories: Categories(
              id: response["categories"][0]["id"],
              categoryName: response["categories"][0]["category_name"],
              categorySlug: response["categories"][0]["category_slug"]));

      if (commentsData != null && commentsData.isNotEmpty) {
        comments.value =
            List<User>.from(commentsData.map((x) => User.fromJson(x)));
      } else {
        comments.clear();
      }

      loading.value = false;
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> createComment() async {
    try {
      if (comment.text.trim().isEmpty) {
        Get.snackbar("Komentar", "Mohon isi Komentar anda");
      } else {
        await ApiService().createComment(slug, comment.text);
        comment.text = "";
        getDetail();
        Get.snackbar(
          "Komentar",
          "Komentar berhasil ditambahkan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> deleteComment(String id) async {
    try {
      await ApiService().deleteComment(id);
      getDetail();
      Get.snackbar(
        "Komentar",
        "Komentar berhasil dihapus",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.snackbar("Komentar", "Berhasil menambahkan Komentar");
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
