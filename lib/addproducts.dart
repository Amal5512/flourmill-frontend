import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

  Future<void> _addProduct() async {
    String url = 'http://localhost:3011/product/add'; // Replace with your backend URL
    Map<String, dynamic> data = {
      'productName': _productNameController.text,
      'productDesc': _productDescriptionController.text,
      'productPrice': double.parse(_priceController.text),
      'productQuantity': int.parse(_quantityController.text),
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Product added successfully
        print('Product added successfully');
        _showSuccessDialog(); // Show success dialog
      } else {
        // Handle error
        print('Error adding product: ${response.body}');
        // You can show an error message to the user
      }
    } catch (error) {
      // Handle network errors
      print('Network error: $error');
      // You can show an error message to the user
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Product added successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _productDescriptionController,
              decoration: InputDecoration(
                labelText: 'Product Description',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addProduct();
                },
                child: Text('Add Product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}