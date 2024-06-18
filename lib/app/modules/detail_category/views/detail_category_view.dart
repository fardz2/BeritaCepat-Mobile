import 'package:berita_mobile/app/widgets/berita_card_single.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  controller.getDetailCategory();
                },
                child: controller.category_news.isEmpty
                    ? const Center(
                        child: Text("Berita Tidak Ditemukan"),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: controller.category_news.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var news = controller.category_news[index];
                          return BeritaCardSingle(
                            titleSlug: news.titleSlug.toString(),
                            thumbnail: news.thumbnail.toString(),
                            title: news.title.toString(),
                            categoryName:
                                news.categories!.categoryName.toString(),
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
