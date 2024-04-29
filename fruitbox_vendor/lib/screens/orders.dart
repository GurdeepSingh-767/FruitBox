import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox_vendor/screens/home.dart';
import 'package:fruitbox_vendor/screens/items.dart';
import 'package:fruitbox_vendor/screens/settings.dart';



class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    _ordersStream = FirebaseFirestore.instance.collection('orders').snapshots();
  }

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vendor App',
          style: TextStyle(
            fontWeight: FontWeight.w100,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFFC201),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final orderData = documents[index].data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Order ID: ${documents[index].id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product: ${orderData['product']}'),
                      Text('Quantity: ${orderData['quantity']}'),
                      Text('Total: ${orderData['total'] != null ? '\$${orderData['total']!.toStringAsFixed(2)}' : 'N/A'}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Add order processing logic here
                      // You can update order status, mark as delivered, etc.
                      // For example, you can remove the order from Firestore
                      FirebaseFirestore.instance.collection('orders').doc(documents[index].id).delete();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC201),
                    ),
                    child: Text(
                      'Process Order',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFC201),
        selectedItemColor: Colors.black, // Color of the active item
        unselectedItemColor: Colors.grey, // Color of inactive items
        currentIndex: 2,
        onTap: (index) {
          // Handle tapping on navigation items
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyItem()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MySetting()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.addchart_outlined), // Use outlined version
            label: 'Listed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined), // Use outlined version
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), // Use outlined version
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
