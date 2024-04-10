// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String id;
  String userName;
  String phoneNo;
  String email;
  String address;
  String password;

  Welcome({
    required this.id,
    required this.userName,
    required this.phoneNo,
    required this.email,
    required this.address,
    required this.password,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["id"],
    userName: json["userName"],
    phoneNo: json["phoneNo"],
    email: json["email"],
    address: json["address"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "userName": userName,
    "phoneNo": phoneNo,
    "email": email,
    "address": address,
    "password": password,
  };
}
