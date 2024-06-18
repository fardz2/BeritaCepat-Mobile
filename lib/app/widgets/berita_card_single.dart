import 'package:berita_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define the custom widget
class BeritaCardSingle extends StatelessWidget {
  final String titleSlug;
  final String thumbnail;
  final String title;
  final String categoryName;

  const BeritaCardSingle({
    super.key,
    required this.titleSlug,
    required this.thumbnail,
    required this.title,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/detail', arguments: titleSlug);
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage("$API_URL/$thumbnail"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines:
                          2, // Ensure it shows a single line with ellipsis
                    ),
                    Text(
                      categoryName,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
