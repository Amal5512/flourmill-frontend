import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Cartmodel {
  final String id;
  final UserModel userId;
  final ProductModel productId;
  final int quantity;
  final int totalPrice;

  Cartmodel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
  });

  factory Cartmodel.fromJson(Map<String, dynamic> json) {
    return Cartmodel(
      id: json['_id'],
      userId: UserModel.fromJson(json['userId']),
      productId: ProductModel.fromJson(json['productId']),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
    );
  }
}

class UserModel {
  final String id;
  final String userName;
  final String phoneNo;
  final String email;
  final String address;

  UserModel({
    required this.id,
    required this.userName,
    required this.phoneNo,
    required this.email,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      userName: json['userName'],
      phoneNo: json['phoneNo'],
      email: json['email'],
      address: json['address'],
    );
  }
}

class ProductModel {
  final String id;
  final String productName;
  final String productDesc;
  final int productPrice;
  final int productQuantity;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productDesc,
    required this.productPrice,
    required this.productQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      productName: json['productName'],
      productDesc: json['productDesc'],
      productPrice: json['productPrice'],
      productQuantity: json['productQuantity'],
    );
  }
}

class CartViewPage extends StatefulWidget {

  @override
  _CartViewPageState createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  List<Cartmodel> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchCartItems(userid);
    getid();
  }
  String userid="";
 void getid()
 async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   userid = prefs.getString("userid") ?? "";
 }

  Future<void> _fetchCartItems(String userId) async {
    var url = Uri.parse('http://localhost:3011/cart/view');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        final cartItemsData = responseData['cartItems'];
        List<Cartmodel> cartItems = [];
        for (var itemData in cartItemsData) {
          cartItems.add(Cartmodel.fromJson(itemData));
        }
        setState(() {
          _cartItems = cartItems;
        });
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: _cartItems.isEmpty
          ? Center(child: Text('No items in the cart'))
          : ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = _cartItems[index];
          final product = cartItem.productId;
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(product.productName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description: ${product.productDesc}'),
                  Text('Price: \$${product.productPrice.toStringAsFixed(2)}'),
                  Text('Quantity: ${cartItem.quantity}'),
                  Text('Total Price: \$${cartItem.totalPrice.toStringAsFixed(2)}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Implement delete functionality here
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
