import 'package:flutter/material.dart';

void main() {
  runApp(SlotBookingApp());
}

class SlotBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slot Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SlotBookingScreen(),
    );
  }
}

class SlotBookingScreen extends StatefulWidget {
  @override
  _SlotBookingScreenState createState() => _SlotBookingScreenState();
}

class _SlotBookingScreenState extends State<SlotBookingScreen> {
  List<String> slots = ['Slot 1', 'Slot 2', 'Slot 3']; // Sample slots

  String selectedSlot = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slot Booking'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Available Slots',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: slots.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSlot = slots[index];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: selectedSlot == slots[index]
                          ? Colors.blue[100]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      slots[index],
                      style: TextStyle(
                        fontSize: 18,
                        color: selectedSlot == slots[index]
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          selectedSlot.isNotEmpty
              ? Text(
            'Selected Slot: $selectedSlot',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
