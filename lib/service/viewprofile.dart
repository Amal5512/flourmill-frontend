import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  UserDetailsPage({required this.userData});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetailsItem(
              title: 'NAME',
              value: widget.userData['userName'], // Assuming house number key is 'houseNumber'
              icon: Icons.account_circle,
              iconColor: Colors.blue,
            ),
            UserDetailsItem(
              title: 'PHONE NUMBER',
              value: widget.userData['phoneNo'],
              icon: Icons.phone,
              iconColor: Colors.blue,
            ),
            UserDetailsItem(
              title: 'ADDRESS',
              value: widget.userData['address'],
              icon: Icons.location_on,
              iconColor: Colors.red,
            ),
            UserDetailsItem(
              title: 'Email',
              value: widget.userData['email'],
              icon: Icons.email,
              iconColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetailsItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  UserDetailsItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}