import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitbox_delivery/screens/deliveryscreen.dart';
import 'package:fruitbox_delivery/screens/home_screen.dart';
import 'package:fruitbox_delivery/screens/SideDrawer.dart';
import 'package:fruitbox_delivery/screens/BottomNavBar.dart';
import 'BottomNavBar.dart';
import 'SideDrawer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  Stream<QuerySnapshot> getOrdersStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: 'Pending')
        .snapshots();
  }

  Future<String> fetchUserAddress(String userId) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      return userData['address'] ?? 'Address not available';
    } else {
      return 'User not found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Orders',
          style: TextStyle(
            fontWeight: FontWeight.w100,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFFFC201),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching orders.'));
          }

          final orders = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final orderData = orders[index].data() as Map<String, dynamic>;
              final orderId = orders[index].id;
              final status = orderData['status'];
              final totalAmount = orderData['totalAmount'];
              final orderDate = orderData['orderDate']; // Convert Timestamp to DateTime
              final orderItems = orderData['orderItems'] as List<dynamic>;
              final userId = orderData['userId']; // Assuming orderData contains userId

              // Convert order date from Timestamp to string
              String orderDateStr = orderDate; // Your original orderDate string
              List<String> dateAndTime = orderDateStr.split('T');
              String datePart = dateAndTime[0];
              String timePart = dateAndTime[1].substring(0, 8);
              String formattedDateTime = '$datePart $timePart';

              return FutureBuilder<String>(
                future: fetchUserAddress(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching user address.'));
                  }

                  String userAddress = snapshot.data ?? 'Address not available';

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Order ID: $orderId'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status: $status'),
                          Text('Total Amount: $totalAmount'),
                          Text('Order Date: $formattedDateTime'),
                          //Text('User ID: $userId'),
                          Text('User Address: $userAddress'),
                          Text('Order Items: ${orderItems.map((item) => '${item['name']} - ${item['quantity']}').join(', ')}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Delivery_Screen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC201),
                        ),
                        child: const Text(
                          'Go for delivery',
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
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: SideDrawer(),
      bottomNavigationBar: const AppBottomNavigationBar(initialIndex: 1),
    );
  }
}