import 'dart:convert';

import 'package:berita_mobile/app/data/Comment.dart';

User commentFromJson(String str) => User.fromJson(json.decode(str));

String commentToJson(User data) => json.encode(data.toJson());

class User {
  final int? id;
  final String? name;
  final Comment? comment;

  User({
    this.id,
    this.name,
    this.comment,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    Comment? comment,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        comment: comment ?? this.comment,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        comment: json["pivot"] == null ? null : Comment.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "comment": comment?.toJson(),
      };
}
