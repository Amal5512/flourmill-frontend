import 'package:demo2/addproducts.dart';
import 'package:flutter/material.dart';

class AdminFront extends StatefulWidget {
  const AdminFront({Key? key}) : super(key: key);

  @override
  State<AdminFront> createState() => _AdminFrontState();
}

class _AdminFrontState extends State<AdminFront> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    AddProducts(),
    Text('Staff Page'),
    Text('Payment Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Staff',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
