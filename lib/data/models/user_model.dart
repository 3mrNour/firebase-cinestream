import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String uid;
  String email;
  String username;
  String firstName;
  String lastName;
  String gender;
  String image;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"]?.toString() ?? '',
    email: json["email"]?.toString() ?? '',
    username: json["username"]?.toString() ?? '',
    firstName: json["firstName"]?.toString() ?? '',
    lastName: json["lastName"]?.toString() ?? '',
    gender: json["gender"]?.toString() ?? '',
    image: json["image"]?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "image": image,
  };
}
