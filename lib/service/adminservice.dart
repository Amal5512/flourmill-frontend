import 'dart:convert';
import 'package:http/http.dart' as http;


class adminApiService
{



  Future<dynamic> logData(
      String email,String password
      ) async
  {
    var client = http.Client();
    var apiUri = Uri.parse("http://localhost:3011/admin/signin");
    var response = await client.post(apiUri,
      headers: <String,String>
      {
        "Content-Type":"application/json; charset=UTF-8"
      },
      body: jsonEncode(<String,String>
      {
        "email" : email,
        "password" : password
      }
      ),
    );
    if(response.statusCode==200)
    {
      var resp = response.body;
      return jsonDecode(resp);
    }
    else
    {
      throw Exception("Failed to send data");
    }
  }
}

