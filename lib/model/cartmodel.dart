// To parse this JSON data, do
//
//     final cartmodel = cartmodelFromJson(jsonString);

import 'dart:convert';

Cartmodel cartmodelFromJson(String str) => Cartmodel.fromJson(json.decode(str));

String cartmodelToJson(Cartmodel data) => json.encode(data.toJson());

class Cartmodel {
  String id;
  String userId;
  ProductId productId;
  int quantity;
  int totalPrice;
  int v;

  Cartmodel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.v,
  });

  factory Cartmodel.fromJson(Map<String, dynamic> json) => Cartmodel(
    id: json["_id"],
    userId: json["userId"],
    productId: ProductId.fromJson(json["productId"]),
    quantity: json["quantity"],
    totalPrice: json["totalPrice"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "productId": productId.toJson(),
    "quantity": quantity,
    "totalPrice": totalPrice,
    "__v": v,
  };
}

class ProductId {
  String id;
  String productName;
  String productDesc;
  int productPrice;
  int productQuantity;
  int v;

  ProductId({
    required this.id,
    required this.productName,
    required this.productDesc,
    required this.productPrice,
    required this.productQuantity,
    required this.v,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"],
    productName: json["productName"],
    productDesc: json["productDesc"],
    productPrice: json["productPrice"],
    productQuantity: json["productQuantity"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "productDesc": productDesc,
    "productPrice": productPrice,
    "productQuantity": productQuantity,
    "__v": v,
  };
}
