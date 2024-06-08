import 'package:berita_mobile/app/routes/app_pages.dart';
import 'package:berita_mobile/services/api_service.dart';

import '../controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainView extends GetView<HomeController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() => controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return controller.getBerita();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
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
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.SEARCH_PAGE);
                                  },
                                  icon: const Icon(Icons.search))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Terbaru",
                                style: TextStyle(fontSize: 15),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/detail',
                                      arguments: controller
                                          .beritaTerbaru.value.titleSlug);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        "$API_URL/${controller.beritaTerbaru.value.thumbnail.toString()}"),
                                    Text(
                                      controller.beritaTerbaru.value.title
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      controller.beritaTerbaru.value.categories!
                                          .categoryName
                                          .toString(),
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Trending",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 400,
                            child: ListView.builder(
                                itemCount: controller.trending.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(left: 15),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/detail',
                                          arguments: controller
                                              .trending.value[index].titleSlug);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      width: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      // ignore: invalid_use_of_protected_member
                                                      "$API_URL/${controller.trending.value[index].thumbnail.toString()}",
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Text(
                                            controller
                                                .trending.value[index].title
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow
                                                .ellipsis, // Mengatur overflow ke TextOverflow.ellipsis
                                            maxLines: 2,
                                          ),
                                          Text(
                                            controller.trending.value[index]
                                                .categories!.categoryName
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),
                ))),
    );
  }
}
