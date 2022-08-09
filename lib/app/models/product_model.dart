// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    required this.id,
    required this.author,
    required this.createdAt,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  String ?id;
  String ?author;
  Timestamp? createdAt;
  String? imageUrl;
  String ?title;
  String ?description;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"] == null ? null : json["id"],
        author: json["author"] == null ? null : json["author"],
        createdAt: json["createdAt"] == null
            ? null
            : json["createdAt"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "createdAt": createdAt,
        "imageUrl": imageUrl,
        "title": title,
        "description": description,
      };
}
