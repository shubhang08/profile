import 'dart:convert';

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Profile({
     required this.username,
    required this.description,
    required this.userId,
    required this.likesCount,
    required this.followers,
    required this.following,
    required this.profilePic,
  });

  String username;
  String description;
  String userId;
  int likesCount;
  int followers;
  int following;
  String profilePic;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        username: json["username"]!,
        description: json["description"]!,
        userId: json["userID"]!,
        likesCount: json["likesCount"]!,
        followers: json["followers"]!,
        following: json["following"]!,
        profilePic: json["profilePic"]!,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "description": description,
        "userID": userId,
        "likesCount": likesCount,
        "followers": followers,
        "following": following,
        "profilePic": profilePic,
      };
}
