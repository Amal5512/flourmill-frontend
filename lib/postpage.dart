import 'dart:convert';

import 'package:demo2/cartpage.dart';
import 'package:demo2/model/productmodel.dart';
import 'package:demo2/service/userservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GroceryHomePage extends StatefulWidget {
@override
_GroceryHomePageState createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  Future<List<ProductModel>>? data;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  String userid="";
  Future<void> fetchData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      userid = pref.getString("userid") ?? "";
      print(userid);
      final response = await http.get(Uri.parse('http://localhost:3011/product/viewall'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          data = Future.value(List<ProductModel>.from(responseData['data'].map((x) => ProductModel.fromJson(x))));
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw Exception('Error fetching data: $error');
    }
  }

  Future<void> addToCart(String productId,String userId) async {
    print(userId);
    try {
      if(userId.isEmpty)
        {
          print("userid is null");
          return;
        }
      final response = await http.post(
        Uri.parse('http://localhost:3011/cart/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId':  userid,// Replace with actual user ID
          'productId': productId,
        }),
      );
      if (response.statusCode == 200) {
        // Handle success message
        print('Added to cart successfully');

      } else {
        // Handle error message
        print('Failed to add to cart: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error adding to cart: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subadmin List'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(product.productName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${product.productDesc}'),
                        Text('Price: ${product.productPrice}'),
                        Text('Quantity: ${product.productQuantity}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        addToCart(product.id,userid);
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
