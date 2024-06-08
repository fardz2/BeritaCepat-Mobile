class Berita {
  int? id;
  String? title;
  String? titleSlug;
  String? thumbnail;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? content;
  final Categories? categories;

  Berita({
    this.id,
    this.title,
    this.titleSlug,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.content,
    this.categories,
  });
}

class Categories {
  int? id;
  String? categoryName;
  String? categorySlug;

  Categories({
    this.id,
    this.categoryName,
    this.categorySlug,
  });
}
