// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  final int? id;
  final String? comment;
  final DateTime? createdAt;

  Comment({
    this.id,
    this.comment,
    this.createdAt,
  });

  Comment copyWith({
    int? id,
    String? comment,
    DateTime? createdAt,
  }) =>
      Comment(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
      };
}
