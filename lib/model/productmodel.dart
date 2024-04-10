// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String id;
  String productName;
  String productDesc;
  int productPrice;
  int productQuantity;
  int v;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productDesc,
    required this.productPrice,
    required this.productQuantity,
    required this.v,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
