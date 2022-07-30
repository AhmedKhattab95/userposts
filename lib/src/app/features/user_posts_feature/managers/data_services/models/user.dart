import 'dart:convert';

List<User> userFromJson(dynamic json) => List<User>.from(json.map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.albumId,
    required this.userId,
    required this.name,
    required this.url,
    required this.thumbnailUrl,
  });

  final int albumId;
  final int userId;
  final String name;
  final String url;
  final String thumbnailUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        albumId: json["albumId"],
        userId: json["userId"],
        name: json["name"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "userId": userId,
        "name": name,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
