import 'package:berita_mobile/app/widgets/berita_card_single.dart';
import 'package:berita_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Berita'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: controller.search,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter a search term',
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.getSearch();
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            Obx(
              () => controller.loading.value
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.getSearch();
                        },
                        child: controller.searchNews.isEmpty
                            ? const Center(
                                child: Text("Berita Tidak Ditemukan"),
                              )
                            : ListView.builder(
                                itemCount: controller.searchNews.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var news = controller.searchNews[index];
                                  return BeritaCardSingle(
                                    titleSlug: news.titleSlug.toString(),
                                    thumbnail: news.thumbnail.toString(),
                                    title: news.title.toString(),
                                    categoryName: news.categories!.categoryName
                                        .toString(),
                                  );
                                },
                              ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
