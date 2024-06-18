import 'package:berita_mobile/app/routes/app_pages.dart';
import 'package:berita_mobile/app/widgets/berita_card.dart';
import 'package:berita_mobile/app/widgets/berita_card_single.dart';

import '../controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainView extends GetView<HomeController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => controller.getBerita(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration:
                              const BoxDecoration(color: Color(0xffE9EEFA)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hello, Faridz"),
                                  Text(
                                    "Nikmati berita hangat",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.toNamed(Routes.SEARCH_PAGE);
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Terbaru",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: controller.beritaTerbaru.length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 15),
                            itemBuilder: (BuildContext context, int index) {
                              return BeritaCard(
                                title: controller.beritaTerbaru[index].title
                                    .toString(),
                                thumbnail: controller
                                    .beritaTerbaru[index].thumbnail
                                    .toString(),
                                categoryName: controller.beritaTerbaru[index]
                                    .categories!.categoryName
                                    .toString(),
                                titleSlug: controller
                                    .beritaTerbaru[index].titleSlug
                                    .toString(),
                                categorySlug: controller.beritaTerbaru[index]
                                    .categories!.categorySlug
                                    .toString(),
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Trending",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: controller.trending.length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 15),
                            itemBuilder: (BuildContext context, int index) {
                              return BeritaCard(
                                title:
                                    controller.trending[index].title.toString(),
                                thumbnail: controller.trending[index].thumbnail
                                    .toString(),
                                categoryName: controller
                                    .trending[index].categories!.categoryName
                                    .toString(),
                                titleSlug: controller.trending[index].titleSlug
                                    .toString(),
                                categorySlug: controller
                                    .trending[index].categories!.categorySlug
                                    .toString(),
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Rekomendasi Untukmu",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: ListView.builder(
                            itemCount: controller.recomendation.length,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            itemBuilder: (BuildContext context, int index) {
                              return BeritaCardSingle(
                                title: controller.recomendation[index].title
                                    .toString(),
                                thumbnail: controller
                                    .recomendation[index].thumbnail
                                    .toString(),
                                categoryName: controller.recomendation[index]
                                    .categories!.categoryName
                                    .toString(),
                                titleSlug: controller
                                    .recomendation[index].titleSlug
                                    .toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
