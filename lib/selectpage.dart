import 'package:demo2/postpage.dart';
import 'package:demo2/service/userservice.dart';
import 'package:demo2/service/viewcart.dart';
import 'package:demo2/service/viewprofile.dart';
import 'package:demo2/slot.dart';
import 'package:demo2/slotbooking.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        primarySwatch: Colors.grey, // Changed primary color to grey
        scaffoldBackgroundColor: Colors.grey[200], // Changed background color to light grey
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey, // Changed app bar color to grey
        ),
      ),
      home: UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String,dynamic>? ProfileScreen;
  String userid="";

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  Future<void> loaddata() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userid = prefs.getString("userid") ?? "";
      print(userid);

      if (userid.isEmpty) {
        print("User ID is empty.");
        return;
      }
      final response = await WelcomeApiService().searchData(userid);
      if (response != null) {
        setState(() {
          if (response["status"] == "success") {
            if (response["data"] != null) {
              print(response);
              ProfileScreen = Map<String, dynamic>.from(response["data"]);
              if (ProfileScreen != null) {
                print('User Name: ${ProfileScreen?["userName"] ?? "N/A"}');
                print('Phone Number: ${ProfileScreen?["phoneNo"] ?? "N/A"}');
                print('Place: ${ProfileScreen?["address"] ?? "N/A"}');
                print('Email: ${ProfileScreen?["email"] ?? "N/A"}');
              }
            } else {
              ProfileScreen = null;
              print('Profile data is null.');
            }
          } else {
            print("Error: ${response["status"]}");
          }
        });
      } else {
        print("Response is null.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CartViewPage()));
            },
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey, // Changed profile header color to grey
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAnftybSA4pP6JDyB0yN-KRMa9K0yjts0gm2m0e_JJRg&s'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${ProfileScreen?['userName'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${ProfileScreen?['email'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailsPage(
                    userData: ProfileScreen ??{}
                  )));
                },
                child: Text(
                  'View Profile',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey, // Changed edit profile button color to grey
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton( // Replaced "View Products" button with TextButton
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>GroceryHomePage()));
                },
                child: Text(
                  'View Products',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton( // Replaced "Book Service" button with TextButton
                onPressed: () {
                  ;
                },
                child: Text(
                  'Book Service',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'My Orders',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text('Order #12345'),
              subtitle: Text('Delivered on 10/04/2024'),
              trailing: Text('\$50.00'),
            ),
            Divider(),
            ListTile(
              title: Text('Order #67890'),
              subtitle: Text('Cancelled'),
              trailing: Text('\$30.00'),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
