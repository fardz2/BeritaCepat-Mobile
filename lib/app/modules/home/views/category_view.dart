import 'package:berita_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:berita_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CategoryView extends GetView<HomeController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Berita'),
        centerTitle: true,
      ),
      body: Obx(() => controller.loading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => controller.getCategory(),
              child: ListView.builder(
                  itemCount: controller.categories.length,
                  itemBuilder: (contex, index) {
                    return ListTile(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_CATEGORY, arguments: [
                          controller.categories[index].categorySlug,
                          controller.categories[index].categoryName
                        ]);
                      },
                      title: Text(
                          controller.categories[index].categoryName.toString()),
                    );
                  }),
            )),
    );
  }
}
