import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final double totalAmount;
  final Function(int) onRemoveItem; // Callback function for item removal

  const CartPage({Key? key, required this.cartItems, required this.totalAmount, required this.onRemoveItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(cartItems[index]["name"]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // Call the callback function to remove the item
                    onRemoveItem(index);
                  },
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: ListTile(
                    title: Text(cartItems[index]["name"]),
                    subtitle: Text("₹${(cartItems[index]["price"] * cartItems[index]["quantity"]).toStringAsFixed(2)} x ${cartItems[index]["quantity"]}"),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle payment logic here
                    // For demonstration purposes, you can just show a payment success pop-up
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Payment Successful"),
                          content: Text("Thank you for your payment."),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Make Payment"),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Total: ₹${totalAmount.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
