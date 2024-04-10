import 'package:demo2/admin_login.dart';
import 'package:demo2/selectpage.dart';
import 'package:demo2/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:demo2/service/userservice.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email="";
  String password="";
  bool _validateEmail = false;
  RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // String? userId;
  TextEditingController n1 = new TextEditingController();
  TextEditingController n2 = new TextEditingController();
  void SendApi() async
  {
    email = n1.text;
    password = n2.text;
    final response = await WelcomeApiService().logData(email,password);
    // final String objectId = response["_id"];
    // final String hexString = objectId.substring(10, 34);
    // print(response);
    if(response["status"]=="success")
    {
      dynamic userdata = response["userData"];
      if (userdata != null && userdata["_id"] != null) {
        String userid = userdata["_id"].toString();
        SharedPreferences prefer = await SharedPreferences.getInstance();
        prefer.setString("userid", userid);
        print("userid $userid");
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        showSimplePopup1(context, "user login success");
      }
    }else {
      showSimplePopup1(context, response["status"]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: Text("FlourDoor"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Options'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('User'),
              onTap: () {
                // Handle user login
              },
            ),
            ListTile(
              title: Text('Admin'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLoginPage()));
              },
            ),
          ],
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(34),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 135,
              ),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: Image.network("https://cdn-icons-png.freepik.com/512/11167/11167023.png",
                    width: 200),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Login",style: TextStyle(fontSize: 40)),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: n1,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  errorText: _validateEmail ? 'Invalid email' : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _validateEmail = !_emailRegExp.hasMatch(value);
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: n2,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 25,
              ),



              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Set the button background color to orange
                ),
                onPressed: _validateEmail ? null : SendApi,
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                  ),
                ),
              ),

              SizedBox(
                height: 25,

              ),
              Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.bold),),
              TextButton(onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
              }, child: Text("Register",style: TextStyle(color: Colors.lightBlue),))
            ],
          ),
        ),
      ),
    );
  }


  void showSimplePopup1(BuildContext context, String s) {
    final snackBar = SnackBar(
      content: Text(s,style: TextStyle(color: Colors.redAccent),),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white70,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  // void showSimplePopup2(BuildContext context, String s) {
  //   final snackBar = SnackBar(
  //     content: Text(s,style: TextStyle(color: Colors.redAccent),),
  //     duration: Duration(seconds: 3),
  //     behavior: SnackBarBehavior.floating,
  //     backgroundColor: Colors.white70,
  //   );
  //
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}

