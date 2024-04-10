import 'dart:convert';
import 'package:demo2/model/productmodel.dart';
import 'package:http/http.dart' as http;

import '../model/cartmodel.dart';


class WelcomeApiService {

  Future<dynamic> sendData(String userName, String phoneNo, String email,
      String address, String password) async
  {
    var client = http.Client();
    var apiUri = Uri.parse("http://localhost:3011/user/signup");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      {"userName": userName,
        "phoneNo": phoneNo,
        "email": email,
        "address": address,
        "password": password
      }
      ),
    );
    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    }
    else {
      throw Exception("Failed to send data");
    }
  }

  Future<dynamic> logData(String email, String password) async
  {
    var client = http.Client();
    var apiUri = Uri.parse("http://localhost:3011/user/signin");
    var response = await client.post(apiUri,
      headers: <String, String>
      {
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, String>
      {
        "email": email,
        "password": password
      }
      ),
    );
    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    }
    else {
      throw Exception("Failed to send data");
    }
  }

  Future<List<ProductModel>> Viewproduct() async {
    var client = http.Client();
    var apiurl = Uri.parse(
        "http://localhost:3011/product/viewall");
    var response = await client.post(apiurl);
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<dynamic> searchData(String userid) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://localhost:3011/user/search");

    try {
      var response = await client.post(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json",
          // Authentication token usually goes in the headers
        },
        body: jsonEncode(<String, String>{
          "id": userid,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);

      } else {
        // Improved error message for debugging
        throw Exception('Failed to search. Status code: ${response.statusCode}. Response body: ${response.body}');
      }
    } finally {
      client.close();
    }
  }
   Future<dynamic> fetchCartItems(String userId) async {
     print("hello $userId");
     var client = http.Client();
     var url = Uri.parse(
         'http://localhost:3011/cart/view'); // Replace with your actual backend URL
     var response = await client.post(
       url,
       headers: <String, String>{
         "Content-Type": "application/json",
         // Authentication token usually goes in the headers
       },
       body: jsonEncode(<String, String>{
         "userId": userId,
       }),
     );
     if (response.statusCode == 200) {
       return json.decode(response.body);
     }
   }
}


