import 'dart:convert';

import 'details_photo.dart';

List<CollectionsPhotos> collectionsPhotosFromJson(String str) =>
    List<CollectionsPhotos>.from(
        json.decode(str).map((x) => CollectionsPhotos.fromJson(x)));

String collectionsPhotosToJson(List<CollectionsPhotos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollectionsPhotos {
  String id;
  DateTime createdAt;
  int width;
  int height;
  String? description;
  Urls urls;
  int likes;
  User user;

  CollectionsPhotos({
    required this.id,
    required this.createdAt,
    required this.width,
    required this.height,
    required this.description,
    required this.urls,
    required this.likes,
    required this.user,
  });

  factory CollectionsPhotos.fromJson(Map<String, dynamic> json) =>
      CollectionsPhotos(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        width: json["width"],
        height: json["height"],
        description: json["description"],
        urls: Urls.fromJson(json["urls"]),
        likes: json["likes"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "width": width,
    "height": height,
    "description": description,
    "urls": urls.toJson(),
    "likes": likes,
    "user": user.toJson(),
  };
}
