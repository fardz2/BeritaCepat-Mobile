import 'package:berita_mobile/app/routes/app_pages.dart';

import 'package:berita_mobile/services/api_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart' as timeago_id;
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('id', timeago_id.IdMessages());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berita'),
        centerTitle: true,
      ),
      body: Obx(() => controller.loading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                return controller.getDetail();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20.0), // Adjust the radius as needed
                        child: Image.network(
                          "$API_URL/${controller.detailBerita.value.thumbnail.toString()}",
                          fit: BoxFit
                              .cover, // This ensures the image covers the entire container
                        ),
                      ),
                      Text(
                        controller.detailBerita.value.title.toString(),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        controller.detailBerita.value.categories!.categoryName
                            .toString(),
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HtmlWidget(
                        controller.detailBerita.value.content.toString(),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.comment,
                        onTap: () {
                          if (controller.user_check.box.read('token') == null) {
                            Get.toNamed(Routes.LOGIN);
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Komentar',
                          suffixIcon: IconButton(
                            onPressed: controller.createComment,
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ),
                      Text(
                        "${controller.comments.length} Komentar",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      controller.comments.isEmpty
                          ? const Text('Komentar Kosong',
                              style: TextStyle(fontSize: 16))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.comments.length,
                              itemBuilder: ((context, index) {
                                var comment = controller.comments[index];
                                return ListTile(
                                  trailing: controller.user_check.box
                                                  .read('role') ==
                                              "admin" ||
                                          controller.user_check.box
                                                  .read("id")
                                                  .toString() ==
                                              comment.comment?.id.toString()
                                      ? IconButton(
                                          onPressed: () {
                                            controller.deleteComment(
                                                comment.comment!.id.toString());
                                          },
                                          icon: const Icon(Icons.delete))
                                      : const SizedBox(
                                          height: 0,
                                        ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comment.name.toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            timeago.format(
                                                comment.comment!.createdAt!,
                                                locale: 'id'),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(controller
                                          .comments[index].comment?.comment ??
                                      ''),
                                );
                              }),
                            ),
                    ],
                  ),
                ),
              ),
            )),
    );
  }
}
