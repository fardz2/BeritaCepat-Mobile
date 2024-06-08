import 'package:berita_mobile/app/data/Berita.dart';
import 'package:berita_mobile/services/api_service.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<Berita> beritaTerbaru = Berita().obs;
  final RxList<Berita> trending = <Berita>[].obs;
  var loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getBerita();
  }

  Future<void> getBerita() async {
    trending.value = [];
    loading.value = true;
    try {
      final response = await ApiService().getBerita();
      final newsBaruData = response["news_baru"];
      String imageUrl = newsBaruData["thumbnail"];
      beritaTerbaru.value = Berita(
          id: newsBaruData["id"],
          title: newsBaruData["title"],
          titleSlug: newsBaruData["title_slug"],
          thumbnail: imageUrl.replaceFirst('http://127.0.0.1:8000/', ''),
          categories: Categories(
              id: newsBaruData["categories"][0]["id"],
              categoryName: newsBaruData["categories"][0]["category_name"],
              categorySlug: newsBaruData["categories"][0]["category_slug"]));

      final trendingsData = response["trendings"];
      for (var trendingData in trendingsData) {
        String imageUrl = trendingData["thumbnail"];
        trending.add(Berita(
            id: trendingData["id"],
            title: trendingData["title"],
            titleSlug: trendingData["title_slug"],
            thumbnail: imageUrl.replaceFirst('http://127.0.0.1:8000/', ''),
            categories: Categories(
                id: trendingData["categories"][0]["id"],
                categoryName: trendingData["categories"][0]["category_name"],
                categorySlug: trendingData["categories"][0]["category_slug"])));
      }

      loading.value = false;
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
