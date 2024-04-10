
import 'package:demo2/login.dart';
import 'package:demo2/service/userservice.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName="";
  String phoneNo="";
  String email="";
  String address="";
  String password="";

  TextEditingController n1 = new TextEditingController();
  TextEditingController n2 = new TextEditingController();
  TextEditingController n3 = new TextEditingController();
  TextEditingController n4 = new TextEditingController();
  TextEditingController n5 = new TextEditingController();

  void SendApi() async
  {
    userName=n1.text;
    phoneNo=n2.text;
    email=n3.text;
    address=n4.text;
    password = n5.text;

    final response = await WelcomeApiService().sendData(userName,phoneNo,email,address,password);
    if(response["status"]=="success")
    {
      showSimplePopup1(context, "Success!");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
    else
    {
      print("Error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Container(
        padding: EdgeInsets.all(34),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 75,
              ),
              Text("Register",style: TextStyle(fontSize: 40)),
              SizedBox(
                height: 15,
              ),
              TextField(
                  style: TextStyle(color: Colors.black),
                  controller: n1,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.black),
                  )
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: n2,
                decoration: InputDecoration(
                  labelText: "mob no",
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: n3,
                decoration: InputDecoration(
                  labelText: "email",
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: n4,
                decoration: InputDecoration(
                  labelText: "address",
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: n5,
                decoration: InputDecoration(
                  labelText: "password",
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),

              SizedBox(
                height: 25,
              ),
              ElevatedButton(onPressed: SendApi, child: Text("Register")),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Back To Login"))
            ],
          ),
        ),
      ),
    );
  }
  void showSimplePopup1(BuildContext context, String s) {
    final snackBar = SnackBar(
      content: Text(s,style: TextStyle(color: Colors.black),),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white70,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}



