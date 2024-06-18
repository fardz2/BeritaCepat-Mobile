import 'package:berita_mobile/app/routes/app_pages.dart';
import 'package:berita_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeritaCard extends StatelessWidget {
  final String title;
  final String thumbnail;
  final String categoryName;
  final String titleSlug;
  final String categorySlug;

  const BeritaCard({
    Key? key,
    required this.title,
    required this.thumbnail,
    required this.categoryName,
    required this.titleSlug,
    required this.categorySlug,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL, arguments: titleSlug);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage("$API_URL/$thumbnail"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.DETAIL_CATEGORY,
                    arguments: [categorySlug, categoryName]);
              },
              child: Text(
                categoryName,
                style: const TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
